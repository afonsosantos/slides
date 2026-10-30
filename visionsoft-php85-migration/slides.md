---
theme: default
title: Migração para PHP 8.5
colorSchema: light
layout: cover
routerMode: hash
addons:
  - slidev-addon-second-screen
fonts:
  sans: 'Poppins'
  serif: 'Poppins'
  mono: 'JetBrains Mono'
  weights: '400,500,600,700'
---

<p class="meta">Formação Interna · Equipa de Desenvolvimento</p>

# Migração para PHP 8.5

<div class="rule"></div>

<p class="lead">O que mudou, configurar localmente (todos ao mesmo tempo) e instalar num cliente.</p>

<p class="meta mt-10">VSoft Industry · <code>feat/upgrade-php-8.5</code></p>
<p class="meta-sub mt-2">Afonso Santos · 29/10/2026</p>

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/logo.svg" class="h-8 object-contain" alt="Visionsoft" />
</div>

<!--
Três partes. A do meio fazemos juntos: no fim da apresentação todos têm o projeto a correr em PHP 8.5.
-->

---

# Agenda

<div class="grid grid-cols-3 gap-8 mt-12">
  <div class="step">
    <span class="step-num">01</span>
    <p class="step-title">O que mudou</p>
    <p class="dim">PHP 8.5, composer, configuração, Administração</p>
  </div>
  <div class="step">
    <span class="step-num">02</span>
    <p class="step-title">Configurar localmente</p>
    <p class="dim">Passo a passo, <strong>todos ao mesmo tempo</strong></p>
  </div>
  <div class="step">
    <span class="step-num">03</span>
    <p class="step-title">Instalar num cliente</p>
    <p class="dim">Submódulo, deploy, testes e rollback</p>
  </div>
</div>

<!--
Primeiro o contexto, rápido. Depois abrem o terminal e seguimos os passos juntos. No fim, o guia para cada cliente.
-->

---

<p class="meta">Parte 01 · O que mudou</p>

# O branch num slide

<div class="grid grid-cols-3 gap-4 mt-6">
  <div class="check-card">
    <p class="check-title">PHP 7.2 → 8.5</p>
    <p class="dim text-sm">Yii 2.0.55 · dompdf 3 · PhpSpreadsheet 5</p>
  </div>
  <div class="check-card">
    <p class="check-title"><code>vendor/</code> fora do git</p>
    <p class="dim text-sm"><code>composer install</code></p>
  </div>
  <div class="check-card">
    <p class="check-title">Config local</p>
    <p class="dim text-sm"><code>php init</code>: Development · QA · Production</p>
  </div>
  <div class="check-card">
    <p class="check-title">17 submódulos</p>
    <p class="dim text-sm">Um <code>company_*</code> por cliente</p>
  </div>
  <div class="check-card">
    <p class="check-title">Uploads</p>
    <p class="dim text-sm">Em <code>company_*/uploads</code></p>
  </div>
  <div class="check-card">
    <p class="check-title">F3 → Administração</p>
    <p class="dim text-sm"><code>/administration/web</code></p>
  </div>
</div>

<p class="dim mt-6">92 commits · <strong>~200 000 linhas removidas</strong> do core</p>

<!--
Seis mudanças. As linhas removidas são código de clientes que foi para os submódulos, etiquetas antigas, logótipos e o BarcodeGenerator copiado.
-->

---
class: text-sm
---

# Dependências

| | Antes | Depois |
|---|---|---|
| PHP | 7.2 | **8.5** |
| Yii | 2.0.49.4 | **2.0.55** |
| dompdf | 0.8.3 | **3.1** |
| PhpSpreadsheet | 1.19 | **5.10** |
| Códigos de barras | cópia no core | `picqer/php-barcode-generator` |
| Testes | — | Codeception 5 · `composer test:common:unit` |

<p class="dim mt-6">Removidos: <code>swiftmailer</code>, <code>php-svg</code>, <code>yii2-faker</code>.</p>

<!--
Tudo subiu de uma vez. O Yii 2.0.55 porque o 2.0.50 ainda tinha avisos de segurança críticos. O composer está fixado à plataforma 8.5.12.
-->

---
class: code-sm
---

# Duas regras novas do PHP 8

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<p class="code-label accent">Ler um índice de null</p>

```php
$linha = $query->asArray()->one(); // null
$linha['nome'];         // 8.5: exceção
$linha['nome'] ?? null; // ✓
```

<p class="dim text-sm mt-2"><strong>Dev:</strong> rebenta. <strong>QA/prod:</strong> fica em <code>common/logs/php85_offset_null.log</code></p>
</div>
<div>
<p class="code-label">Deprecations</p>

```php
// common/config/bootstrap.php
error_reporting(E_ALL & ~E_DEPRECATED
                      & ~E_USER_DEPRECATED);
```

<p class="dim text-sm mt-2">Escondidas por agora (<code>utf8_encode</code>, <code>strftime</code>…)</p>
</div>
</div>

<!--
O erro mais comum do PHP 8 é ler um índice de algo que é null. Em dev queremos vê-lo e corrigir; em produção fica registado num log, que é a lista do que falta corrigir. As deprecations não fazem nada hoje, por isso estão escondidas até limparmos o código. Outras duas coisas, sem impacto no dia a dia: as colunas bit continuam a ser 0/1 (MssqlSchema), e as conversões de charset passam pela classe Encoding. Novo também: a estrutura das tabelas (schemaCache, 1 hora) e as permissões de cada utilizador (5 minutos) passaram a estar em cache.
-->

---

# Configuração: o que vai para o git

<div class="grid grid-cols-2 gap-6 mt-8">
  <div class="check-card">
    <p class="check-title">No git</p>
    <ul class="text-sm">
      <li><code>common/config/main.php</code></li>
      <li><code>environments/{dev,qa,prod}/</code></li>
      <li><code>company_*/params.php</code></li>
    </ul>
  </div>
  <div class="check-card">
    <p class="check-title">Fora do git · <code>php init</code></p>
    <ul class="text-sm">
      <li><code>common/config/db.php</code> · a BD</li>
      <li><code>common/config/bootstrap-local.php</code> · o cliente</li>
      <li><code>*-local.php</code>, <code>web/index.php</code>, <code>yii</code></li>
      <li><code>company_*/params-local.php</code> · à mão, só dev</li>
    </ul>
  </div>
</div>

<div class="grid grid-cols-3 gap-4 mt-8 text-center">
  <div class="status-card status-ok"><p class="status-name">Development</p><p class="status-desc">debug + faixa verde</p></div>
  <div class="status-card status-warn"><p class="status-name">QA</p><p class="status-desc">igual a prod + faixa laranja</p></div>
  <div class="status-card" style="border-color: var(--rule)"><p class="status-name">Production</p><p class="status-desc">sem faixa</p></div>
</div>

<!--
O que é igual em todo o lado está no git; o que é de cada servidor é criado pelo php init. Saíram do repositório o db2.php, db3.php, main-local.php, params-local.php e os .example. O php init nunca substitui o db.php nem o bootstrap-local.php.
-->

---
class: text-sm
---

# Onde está cada configuração

| O quê | Onde |
|---|---|
| BD do VSoft | `common/config/db.php` |
| Cliente ativo | `common/config/bootstrap-local.php` |
| ERP (`db2` + API), URLs, logótipos, flags | `company_<cliente>/params.php` |
| O mesmo, só na tua máquina (ERP de teste) | `company_<cliente>/params-local.php` |
| Timezone, tamanho dos anexos, etiquetas | **Administração › Configurações projeto** |

<div class="check-card mt-8">
  <p class="check-title">O F3 já não existe → Administração</p>
  <p class="dim">App à parte em <code>/administration/web</code>, com login próprio (SQLite).</p>
  <p class="mt-2"><code>php yii administrador/guardar &lt;user&gt; &lt;pass&gt;</code></p>
</div>

<!--
O ConfigVSoft desapareceu: o que era do cliente foi para o params.php do submódulo, o resto para as Configurações do projeto. A Administração vem do pacote yii2-administration e tem contas próprias, fora da BD do cliente.
-->

---
class: code-sm
---

# Overrides em dev: <code>params-local.php</code>

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<p class="code-label">company_frigosto/params-local.php</p>

```php
<?php
// só as chaves a mudar; o resto vem do params.php
return [
    'integrations' => [
        'erp-to-vsoft' => [
            'dsn' => 'sqlsrv:Server=localhost\ERP;'
                . 'Database=bd_teste',
            'username' => 'sa',
            'password' => '...',
        ],
        'vsoft-to-erp' => [
            'baseURL' => 'http://localhost:81/api/',
        ],
    ],
];
```
</div>
<div>
<ul class="checklist">
<li>Criado <strong>à mão</strong>, ao lado do <code>params.php</code></li>
<li>Fora do git (<code>.gitignore</code> do submódulo)</li>
<li>Só em <strong>Development</strong>: em QA/prod é ignorado</li>
<li>Merge recursivo (<code>ArrayHelper::merge</code>)</li>
</ul>
<p class="dim text-sm mt-4">Para apontar ao ERP de teste sem mexer no <code>params.php</code> do cliente.</p>
</div>
</div>

<!--
Antes, para testar contra um ERP de teste, mudava-se o params.php e havia o risco de ir para o git com as credenciais erradas. Agora o params.php fica igual ao de produção e cada um põe por cima, na sua máquina, só as chaves que muda. O merge é recursivo: não é preciso repetir o class, o charset, etc. Só é lido com YII_ENV_DEV, por isso mesmo que o ficheiro vá parar a um servidor não tem efeito.
-->

---
layout: center
---

<p class="meta">Parte 02</p>

# Configurar localmente

<div class="rule"></div>

<p class="lead">Abram o terminal. Vamos fazer isto juntos.</p>

<!--
A partir daqui, um passo por slide. Esperamos que todos acabem cada passo antes de avançar.
-->

---

<p class="passo-num">Passo 0 · Pré-requisitos</p>

# A máquina

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<ul class="checklist">
<li><code>php -v</code> → <strong>8.5</strong></li>
<li>Apache com o mesmo PHP 8.5</li>
<li><code>sqlsrv</code> + <code>pdo_sqlsrv</code> para 8.5</li>
<li>Composer</li>
<li><code>mod_rewrite</code> + <code>AllowOverride</code></li>
</ul>
</div>
<div class="code-sm">
<p class="code-label">php.ini</p>

```ini
output_buffering = On
upload_max_filesize = 200M
post_max_size = 200M
memory_limit = 4G
date.timezone = "Europe/Lisbon"
extension=zip
```
</div>
</div>

<!--
Se o php -v mostrar 7.2, o terminal ainda aponta para o XAMPP: corrigir o PATH e abrir um terminal novo. O output_buffering On é obrigatório por causa do phpGrid. Sem mod_rewrite as imagens antigas não abrem.
-->

---
class: big-code
---

<p class="passo-num">Passo 1 / 9 · GitHub</p>

# Instalar o GitHub CLI

```powershell
winget install --id GitHub.cli -e
```

<p class="hint">Depois, <strong>abrir um PowerShell novo</strong> (para o <code>gh</code> ficar no PATH).<br>Os comandos partidos em várias linhas usam <code>`</code>: colar o bloco inteiro.</p>

<!--
O clone usa SSH, por isso a conta do GitHub precisa de uma chave. O GitHub CLI cria-a e regista-a por nós. A conta tem de ter acesso à organização Visionsoft-Software-Solutions.
-->

---
class: big-code
---

<p class="passo-num">Passo 2 / 9 · GitHub</p>

# Login com SSH

```powershell
gh auth login `
  --hostname github.com `
  --git-protocol ssh `
  --web
```

<ul class="plain-list hint">
<li>Chave SSH: <strong>gerar uma nova</strong> (ou usar a de <code>~/.ssh</code>)</li>
<li>Passphrase: <strong>vazia</strong></li>
<li>Copiar o código → confirmar no browser</li>
</ul>

<!--
O gh envia a chave pública para a conta automaticamente.
-->

---
class: big-code
---

<p class="passo-num">Passo 3 / 9 · GitHub</p>

# Confirmar

```powershell
gh auth status
ssh -T git@github.com
```

<p class="hint">Esperado: <code>Hi &lt;utilizador&gt;! You've successfully authenticated</code><br>Na primeira ligação, responder <code>yes</code>.</p>

<!--
Se aparecer Permission denied (publickey), o login do passo 2 não registou a chave.
-->

---

<p class="passo-num">Passo 4 / 9 · Projeto antigo</p>

# Guardar e apagar

<ul class="checklist text-xl mt-8">
<li><strong>Push</strong> de todo o trabalho por enviar</li>
<li>Copiar <code>common/config/db.php</code> <strong>para fora</strong> do projeto (tem os dados da BD)</li>
<li>Apagar a pasta do projeto</li>
</ul>

<!--
Clone novo em vez de pull: o vendor saiu do git e há 17 submódulos para trazer. Guardem o db.php, vamos precisar dele no passo 8.
-->

---
class: big-code url-longo
---

<p class="passo-num">Passo 5 / 9 · Clonar</p>

# Clonar com os submódulos

```powershell
git clone --recurse-submodules `
  -b feat/upgrade-php-8.5 `
  git@github.com:Visionsoft-Software-Solutions/vsoft-plastics.git
cd vsoft-plastics
```

<p class="hint">Na pasta onde querem o projeto. Traz o core e os 17 <code>company_*</code>.</p>

<!--
Demora um pouco por causa dos submódulos.
-->

---
class: big-code
---

<p class="passo-num">Passo 6 / 9 · Instalar</p>

# Dependências e config local

```powershell
composer install
php init --env=Development --overwrite=All
```

<p class="hint">O <code>php init</code> cria o <code>db.php</code>, o <code>bootstrap-local.php</code> e os <code>*-local.php</code>.</p>

<!--
O composer vai buscar o yii2-administration, que é privado; o auth.json do repositório trata do acesso.
-->

---
class: big-code
---

<p class="passo-num">Passo 7 / 9 · Cliente</p>

# Escolher o cliente

```powershell
php yii company
php yii company/switch frigosto
```

<p class="hint">O primeiro lista os clientes (<code>*</code> = ativo). Sem nome, o <code>switch</code> lista-os e pergunta qual ativar.</p>

<!--
O switch escreve o bootstrap-local.php por nós; não é preciso editá-lo à mão. Para mudar de cliente mais tarde, é o mesmo comando.
-->

---
class: code-sm
---

<p class="passo-num">Passo 8 / 9 · Base de dados</p>

# Ligar à BD

<p class="code-label mt-2">common/config/db.php</p>

```php {3-6}
return [
    'class' => 'yii\db\Connection',
    'dsn' => 'sqlsrv:Server=localhost\INSTANCIA;Database=VSoft.Plastics;'
        . 'TrustServerCertificate=true',
    'username' => '',
    'password' => '',
    'charset' => 'utf8',
    'enableSchemaCache' => true,
    'schemaCacheDuration' => 3600,
    'schemaCache' => 'cache',
    'attributes' => ['FormatDecimals' => true],
];
```

<p class="hint">Servidor, BD, utilizador e password: <strong>da cópia do passo 4</strong>.</p>

<!--
Só mudam as três linhas destacadas. O schemaCache é novo: a estrutura das tabelas fica em cache uma hora, por isso não copiem o db.php antigo por cima, só os dados da ligação.
-->

---
class: big-code
---

<p class="passo-num">Passo 9 / 9 · Arrancar</p>

# Migrar e criar a conta

```powershell
php yii migrate
php yii administrador/guardar <user> <pass>
```

<p class="hint">A conta serve para entrar na Administração (<code>/administration/web</code>).</p>

<!--
As migrações correm na BD do passo 8. A conta da Administração fica numa base SQLite local.
-->

---

<p class="passo-num">Feito</p>

# Verificar

<ul class="checklist text-xl mt-8">
<li>Backend abre com a faixa verde <strong>DESENVOLVIMENTO</strong></li>
<li>Logótipo e cores do cliente no login</li>
<li>Login na Administração</li>
<li><code>composer test:common:unit</code> passa</li>
</ul>

<!--
Quem tiver tudo verde, ajuda o colega do lado.
-->

---
class: text-sm
---

# Se falhar

| Erro | Solução |
|---|---|
| `Falta common/config/bootstrap-local.php` | `php init --env=Development` |
| `O @company ... não existe` | `php yii company/switch` · `git submodule update --init` |
| `Permission denied (publickey)` | Repetir o passo 2 |
| Erros de sintaxe no composer | O terminal usa o PHP 7.2 → PATH |
| Grelhas em branco | `output_buffering = On` |
| Imagens antigas dão 404 | `mod_rewrite` + `AllowOverride` |

<!--
O que nos aconteceu durante a migração. As mensagens do bootstrap já dizem o que fazer.
-->

---

# No dia a dia

<div class="grid grid-cols-2 gap-x-10 gap-y-6 mt-8">
  <div><p class="code-label">Mudar de cliente</p><p><code>php yii company/switch</code></p></div>
  <div><p class="code-label">Depois de um pull</p><p><code>git submodule update --init</code></p></div>
  <div><p class="code-label">Mudou o composer.lock</p><p><code>composer install</code></p></div>
  <div><p class="code-label">Migrações novas</p><p><code>php yii migrate</code></p></div>
  <div><p class="code-label">Valores antigos</p><p><code>php yii cache/flush cache</code></p></div>
  <div><p class="code-label">Alterou phpGrid</p><p>subir <code>PhpGridManager::$version</code></p></div>
  <div><p class="code-label">Tabelas alteradas fora do migrate</p><p><code>php yii cache/flush cache</code></p></div>
  <div><p class="code-label">Permissões alteradas por SQL</p><p><code>php yii cache/flush cache</code> (ou 5 min)</p></div>
</div>

<!--
Oito situações. Os ficheiros locais nunca vão para o git. A estrutura das tabelas fica em cache uma hora: coluna nova criada à mão só aparece depois do flush. As permissões ficam em cache 5 minutos e limpam-se sozinhas quando são alteradas pelo ecrã; SQL à mão nas tabelas de permissões precisa do flush ou de esperar.
-->

---
layout: center
---

<p class="meta">Parte 03</p>

# Instalar num cliente

<div class="rule"></div>

<p class="lead">A · Submódulo &nbsp;·&nbsp; B · Deploy &nbsp;·&nbsp; C · Testes &nbsp;·&nbsp; D · Rollback</p>

<!--
Este é o guia da tarefa Tarefas para migração no ClickUp. Os 17 clientes atuais já têm submódulo; a parte A é para clientes novos.
-->

---

<p class="passo-num">A · Criar o submódulo (cliente novo)</p>

# Um repositório por cliente

<ol class="mt-4">
<li><em>Use this template</em> no GitHub → repositório <strong>privado</strong> <code>vsoft-industry-company-{cliente}</code></li>
<li>Mover do core: <code>interfaceERP/</code>, <code>etiquetas/</code>, fórmula própria → <code>strategies/</code></li>
<li>Namespaces: <code>company\interfaceERP</code> · <code>company\etiquetas</code> · <code>company\strategies</code></li>
<li>Logótipos <strong>da produção</strong> em <code>assets/</code> · cores em <code>assets/styles.css</code></li>
<li>No core: <code>git submodule add &lt;url&gt; company_&lt;cliente&gt;</code></li>
</ol>

<!--
O README do template tem a estrutura e os comandos git. Procurar referências antigas aos namespaces, por exemplo common\etiquetas\config\CLIENTE\GestaoEtiquetas. Os logótipos vêm sempre da instalação em produção, não do repositório.
-->

---
class: code-sm
---

<p class="passo-num">A · params.php</p>

# A configuração do cliente

```php
$params = [
    'company' => 'FRIGOSTO',                       // antigo ConfigVSoft::empresa
    'integrations' => [
        'erp-to-vsoft' => [/* antigo db2.php */],   // ler do ERP
        'vsoft-to-erp' => [/* credenciais API */],  // enviar ao ERP
    ],
    'urlManagers' => [/* baseUrl, antes no main-local.php */],
    'branding' => ['logo' => '...', 'loginBackground' => '...'],
    // flags: autorizaPausa, integrarConsumos, integrarEtiquetas, utilizarCortante
    // codigoBarras, calculationStrategyClass (se tiver fórmula própria)
];

if (YII_ENV_DEV && is_file(__DIR__ . '/params-local.php')) {  // overrides de dev
    $params = \yii\helpers\ArrayHelper::merge($params, require __DIR__ . '/params-local.php');
}

return $params;
```

<p class="dim text-sm mt-2">Cliente novo: o template já traz o bloco do <code>params-local.php</code> e o <code>.gitignore</code>.</p>

<!--
Um ficheiro com os valores de produção. O comentário de cada chave diz de onde vinha o valor antigo. O bloco do fim é o dos overrides de dev que vimos na parte 1: copiem-no tal como está.
-->

---

<p class="passo-num">B · Deploy · antes</p>

# Preparar

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<p class="code-label">Backups</p>
<ul class="checklist">
<li>Base de dados</li>
<li><code>*/web/uploads/</code></li>
<li><code>common/config/*-local.php</code>, <code>db*.php</code></li>
</ul>
</div>
<div>
<p class="code-label accent">Servidor</p>
<ul class="checklist">
<li>PHP <strong>8.5</strong> + php.ini do passo 0</li>
<li><code>mod_rewrite</code> + <code>AllowOverride FileInfo</code></li>
<li>Escrita em <code>company_*/uploads/</code></li>
</ul>
</div>
</div>

<!--
O PHP 8.5 é uma mudança no servidor: tem de estar instalado antes de copiar o projeto. Sem mod_rewrite as imagens e os documentos antigos deixam de abrir.
-->

---
class: big-code
---

<p class="passo-num">B · Deploy</p>

# Instalar

```powershell
php init --env=Production
php yii company/switch <cliente>
php yii migrate
php yii company/migrate-uploads
php yii cache/flush cache
```

<ul class="checklist hint">
<li><code>db.php</code> → BD</li>
<li><code>migrate-uploads</code> termina com <strong>Erros: 0</strong> · rever os "já existe"</li>
<li>Administração: <code>ConfigVSoft</code> → <em>Etiquetas</em> · <code>anexos_tamanho_maximo_mb</code></li>
</ul>

<!--
No cliente não há git: o build do projeto com o company ainda está em curso, por isso o código é copiado. Num servidor de testes, --env=QA. O migrate-uploads nunca substitui ficheiros; os que já existem ficam na origem para rever à mão. O tamanho máximo dos anexos (default 10 MB) passou a valer para todos os uploads.
-->

---

<p class="passo-num">C · Testes</p>

# Depois do deploy

<div class="grid grid-cols-3 gap-4 mt-6">
  <div class="check-card"><p class="check-title">Login</p><p class="dim text-sm">Logótipo, fundo, cores, 404</p></div>
  <div class="check-card"><p class="check-title">Imagens antigas</p><p class="dim text-sm">Máquina, ficha técnica, utilizador</p></div>
  <div class="check-card"><p class="check-title">Uploads</p><p class="dim text-sm">Imagem, documento, PDF de receção</p></div>
  <div class="check-card"><p class="check-title">PDFs</p><p class="dim text-sm">Ficha técnica, OP, ensaio, packing list</p></div>
  <div class="check-card"><p class="check-title">ERP</p><p class="dim text-sm">Ler (db2) e enviar um documento</p></div>
  <div class="check-card"><p class="check-title">Etiquetas</p><p class="dim text-sm">Imprimir uma etiqueta de produto</p></div>
</div>

<!--
Imagens antigas: no backend e no kiosk. Uploads: confirmar que a thumbnail da máquina é criada. PDFs: ficha técnica com imagem no backend e no frontend. No fim do dia, ver o php85_offset_null.log.
-->

---

<p class="passo-num">D · Rollback</p>

# Se correr mal

<ol class="mt-6 text-lg">
<li><code>php yii company/revert-uploads</code> <span class="dim">(ainda com o código novo)</span></li>
<li>Repor o código anterior e o PHP anterior no Apache</li>
<li>Repor <code>db2.php</code> e <code>main-local.php</code> do backup</li>
<li>Repor a BD, se as migrações já correram</li>
</ol>

<p class="lead mt-10">Por isso os backups não são opcionais.</p>

<!--
O revert-uploads devolve cada ficheiro à pasta de onde veio, a partir do registo que o migrate-uploads deixou. Em alternativa, copiar company_cliente/uploads para backend/web/uploads com a mesma estrutura.
-->

---

# A seguir

<div class="grid grid-cols-3 gap-8 mt-10">
  <div class="step">
    <span class="step-num">01</span>
    <p class="step-title">Build para clientes</p>
    <p class="dim">Projeto + company sem git no servidor</p>
  </div>
  <div class="step">
    <span class="step-num">02</span>
    <p class="step-title">Limpar o PHP 8</p>
    <p class="dim">Deprecations e <code>php85_offset_null.log</code></p>
  </div>
  <div class="step">
    <span class="step-num">03</span>
    <p class="step-title">Merge</p>
    <p class="dim">Review e merge para <code>development</code></p>
  </div>
</div>

<a href="https://app.clickup.com/t/12493t4jtke" target="_blank" class="task-link mt-10">
  <span>
    <span class="code-label">Erros ou melhorias no guia → comentário na tarefa</span>
    <span class="task-name">Tarefas para migração</span>
  </span>
  <code>#12493t4jtke</code>
</a>

<!--
Fica a faltar o build para os clientes, limpar as redes de segurança do PHP 8 e tirar o auth.json do repositório. Se encontrarem um passo errado, comentem na tarefa.
-->

---
layout: end
class: text-center
---

# Perguntas?

<div class="rule"></div>

<p class="lead">Todos com faixa verde? Então está feito.</p>

<div class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-6">
  <img src="/logo.svg" class="h-7 object-contain" alt="Visionsoft" />
</div>
