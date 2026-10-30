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

<div class="grid grid-cols-4 gap-8 mt-12">
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
    <p class="dim">Guia em 9 passos, do pacote aos testes</p>
  </div>
  <div class="step">
    <span class="step-num">04</span>
    <p class="step-title">Atualizar um cliente</p>
    <p class="dim">Updates no teu PC e no Builder</p>
  </div>
</div>

<!--
Primeiro o contexto, rápido. Depois abrem o terminal e seguimos os passos juntos. No fim, o guia para cada cliente e para as versões seguintes.
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
  <div class="status-card" style="border-color: var(--rule)"><p class="status-name">Production</p><p class="status-desc">sem faixa · com debug</p></div>
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

<div class="note-grid grid grid-cols-2 gap-x-10 gap-y-6 mt-8">
  <div><p class="code-label">Mudar de cliente</p><p><code>php yii company/switch</code></p></div>
  <div><p class="code-label">Depois de um pull</p><p><code>git submodule update --init</code></p></div>
  <div><p class="code-label">Mudou o composer.lock</p><p><code>composer install</code></p></div>
  <div><p class="code-label">Nova versão da Administração</p><p><code>composer update vsoft/yii2-administration</code></p></div>
  <div><p class="code-label">Correr os testes</p><p><code>composer test:common:unit</code></p></div>
  <div><p class="code-label">Migrações novas</p><p><code>php yii migrate</code></p></div>
  <div><p class="code-label">Valores antigos</p><p><code>php yii cache/flush cache</code></p></div>
  <div><p class="code-label">Alterou phpGrid</p><p>subir <code>PhpGridManager::$version</code></p></div>
  <div><p class="code-label">Tabelas alteradas fora do migrate</p><p><code>php yii cache/flush cache</code></p></div>
  <div><p class="code-label">Permissões alteradas por SQL</p><p><code>php yii cache/flush cache</code> (ou 5 min)</p></div>
</div>

<!--
Dez situações. Os ficheiros locais nunca vão para o git. O composer install instala o que está no composer.lock; a Administração está em dev-main, por isso uma versão nova dela só entra com o composer update do pacote, e o composer.lock alterado vai para o git. A estrutura das tabelas fica em cache uma hora: coluna nova criada à mão só aparece depois do flush. As permissões ficam em cache 5 minutos e limpam-se sozinhas quando são alteradas pelo ecrã; SQL à mão nas tabelas de permissões precisa do flush ou de esperar.
-->

---
layout: center
---

<p class="meta">Parte 03</p>

# Instalar num cliente

<div class="rule"></div>

<p class="lead">Primeira instalação e migração para o 8.5 · 9 passos</p>

<!--
Este é o guia da tarefa Tarefas para migração no ClickUp. Primeiro o resumo, que serve de consulta rápida; depois um slide por passo. No fim, o que fazer se correr mal e como criar um cliente novo.
-->

---
class: resumo
---

<p class="passo-num">Instalar · Resumo</p>

# Instalar num cliente

| | Onde | O que fazer |
|---|---|---|
| 1 | PC | `task pacote CLIENTE=omelro MODULOS=fruits` |
| 2 | Servidor | Backup da BD · PHP 8.5 instalado |
| 3 | Servidor | Renomear a pasta para `vsoft-antigo` · extrair o zip com o nome antigo |
| 4 | Servidor | `common\config\db.php`: servidor, BD, user e pass |
| 5 | Servidor | `php yii migrate` |
| 6 | Servidor | `php yii company/migrate-uploads --de=C:\www\vsoft-antigo` |
| 7 | Servidor | `php yii cache/flush cache` |
| 8 | Administração | Valores do `ConfigVSoft.php` antigo → Configurações projeto |
| 9 | Browser | Testar: login, barra do debug, imagens, PDFs, ERP, etiquetas |

<p class="dim text-sm mt-3">Os passos 5 a 7 correm-se na pasta da aplicação. Antes da primeira vez: instalar o Task (slide seguinte).</p>

<!--
Este slide é o guia de bolso: com prática, chega. Os slides seguintes são um por passo, com o que deve aparecer no fim de cada um.
-->

---
class: big-code
---

<p class="passo-num">Antes de começar · Só uma vez · No teu PC</p>

# Instalar o Task

```powershell
winget install Task.Task
```

<p class="resultado">Num PowerShell novo, <code>task --version</code> mostra a versão.</p>

<p class="hint">Também é preciso o 7-Zip: quem não o tiver, <code>winget install 7zip.7zip</code>.</p>

<!--
O Task corre as tarefas do Taskfile.yml do projeto (task pacote, task update). O 7-Zip faz o zip; é encontrado no PATH ou na pasta normal de instalação (C:\Program Files\7-Zip).
-->

---
class: big-code
---

<Trilho guia="instalar" :passo="1" />

# Criar o pacote

<p class="onde">No teu PC, na pasta do projeto</p>

```powershell
task pacote CLIENTE=omelro MODULOS=fruits
```

<p class="resultado">Acaba com <code>Pacote pronto: …\dist\VSoftIndustry-omelro-v….zip</code></p>

<p class="hint">Sem módulos: <code>MODULOS=core</code>. Sem <code>CLIENTE</code>, mostra a lista de clientes.</p>

<!--
Demora uns 3 minutos. Leva tudo: código, vendor, config de produção, debug e só os módulos do cliente. Só vai o que tem commit. Sem MODULOS vão todos os módulos. O Builder faz o mesmo zip: Gerar build completo (parte 04).
-->

---

<Trilho guia="instalar" :passo="2" />

# Preparar o servidor

<p class="onde">No servidor</p>

<ul class="checklist text-xl">
<li>Backup da <strong>base de dados</strong></li>
<li>PHP <strong>8.5</strong> instalado (como na parte 02)</li>
</ul>

<p class="resultado">A pasta atual fica onde está: é o backup do código e dos uploads.</p>

<!--
O php da linha de comandos também tem de ser o 8.5 (php -v). No Apache: mod_rewrite e AllowOverride FileInfo, senão as imagens e os documentos antigos deixam de abrir. O Apache tem de poder escrever em company_*/uploads.
-->

---

<Trilho guia="instalar" :passo="3" />

# Extrair o pacote

<p class="onde">No servidor</p>

<ol class="text-xl">
<li>Renomear a pasta atual para <code>vsoft-antigo</code></li>
<li>Extrair o zip para uma pasta com <strong>o nome antigo</strong></li>
</ol>

<p class="resultado">Ficam duas pastas: <code>vsoft-antigo</code> e a nova, com o nome de sempre.</p>

<!--
O mesmo nome: o Apache e o cron.bat continuam a funcionar. Da pasta antiga não se copia nada à mão: nem o main-local.php (ligava o gii, que já não existe: a aplicação vai abaixo) nem o db2.php (passou para o params.php do submódulo). Os uploads vêm no passo 6.
-->

---

<Trilho guia="instalar" :passo="4" />

# Ligar à base de dados

<p class="onde">No servidor, na pasta nova: <code>common\config\db.php</code></p>

<ul class="checklist text-xl">
<li>Servidor e base de dados</li>
<li>Utilizador e password</li>
</ul>

<p class="resultado">Os valores estão no <code>db.php</code> do <code>vsoft-antigo</code>: copiar só esses, não o ficheiro.</p>

<!--
O resto da configuração já vem no pacote. O db.php novo tem o schemaCache: copiar o antigo por cima perdia-o.
-->

---
class: big-code
---

<Trilho guia="instalar" :passo="5" />

# Migrar a base de dados

<p class="onde">No servidor, na pasta nova</p>

```powershell
php yii migrate
```

<p class="resultado">Pergunta se aplica: responder <strong>yes</strong>. Acaba com <code>Migrated up successfully.</code></p>

<!--
Antes disto, o backup da BD do passo 2: a partir daqui o rollback precisa dele.
-->

---
class: big-code
---

<Trilho guia="instalar" :passo="6" />

# Trazer os uploads

<p class="onde">No servidor, na pasta nova</p>

```powershell
php yii company/migrate-uploads --de=C:\www\vsoft-antigo
```

<p class="resultado">Acaba com <strong>Erros: 0</strong>. A pasta antiga fica intacta.</p>

<!--
Copia os web\uploads do backend, frontend e picking da instalação antiga para a pasta do cliente (company_<cliente>\uploads). Nunca substitui ficheiros: os "já existe" são o mesmo caminho em duas apps, rever à mão se houver.
-->

---
class: big-code
---

<Trilho guia="instalar" :passo="7" />

# Limpar a cache

<p class="onde">No servidor, na pasta nova</p>

```powershell
php yii cache/flush cache
```

<p class="resultado">Pergunta se limpa: responder <strong>yes</strong>.</p>

---
class: text-sm
---

<Trilho guia="instalar" :passo="8" />

# Configuração antiga → Administração

<p class="onde">Na Administração → <em>Configurações projeto</em> → Backend</p>

| `ConfigVSoft.php` antigo | Na Administração |
|---|---|
| `caminhoLayoutsEtiquetas` | Etiquetas · Caminho dos layouts das etiquetas |
| `caminhoFicheiroImpressaoEtiqueta` | Etiquetas · Caminho do ficheiro de impressão |
| `timezone` | Gerais · Timezone da aplicação |

<p class="hint">O ficheiro antigo: <code>vsoft-antigo\common\components\ConfigVSoft.php</code></p>

<p class="resultado">Gravar. Em <em>Gerais</em>, rever também o tamanho máximo dos anexos.</p>

<!--
O ConfigVSoft.php já não existe: o resto dele (empresa, BD do ERP, integrações) passou para o submódulo do cliente e já vem no pacote. Copiar os valores do ficheiro antigo, sem mudar nada: os caminhos de rede das etiquetas são diferentes em cada cliente. O anexos_tamanho_maximo_mb (default 10 MB) passou a valer para todos os uploads.
-->

---

<Trilho guia="instalar" :passo="9" />

# Testar

<p class="onde">No browser</p>

<ul class="checklist grid grid-cols-2 gap-x-10 text-lg">
<li><strong>Login</strong>: logótipo, cores e a <strong>barra do debug</strong> em baixo</li>
<li><strong>Imagens antigas</strong>: máquina, ficha técnica, utilizador</li>
<li><strong>Uploads</strong>: imagem, documento, PDF de receção</li>
<li><strong>PDFs</strong>: ficha técnica, OP, ensaio, packing list</li>
<li><strong>ERP</strong>: ler e enviar um documento</li>
<li><strong>Etiquetas</strong>: imprimir uma de produto</li>
</ul>

<p class="resultado">Tudo bem? Está instalado. Algo falha? Slide seguinte.</p>

<!--
A barra do debug vem ligada no pacote: no backend e no picking para todos, no frontend só no próprio servidor (para não tapar o ecrã dos terminais). Sem gii em produção. Se faltar a barra, o pacote não veio do task pacote nem do Builder. Imagens antigas: no backend e no kiosk. Uploads: confirmar que a thumbnail da máquina é criada. No fim do dia, ver o php85_offset_null.log.
-->

---

<p class="passo-num">Instalar · Se correr mal</p>

# Se correr mal

<ol class="mt-6 text-lg">
<li>O PHP anterior no Apache</li>
<li>Renomear: <code>vsoft</code> → <code>vsoft-novo</code>, <code>vsoft-antigo</code> → <code>vsoft</code></li>
<li>Repor a BD, se as migrações já correram</li>
</ol>

<p class="lead mt-10">Por isso os backups não são opcionais.</p>

<!--
A pasta antiga ficou intacta, com os uploads e a config de antes. Só ficam de fora os uploads feitos depois do deploy: estão em vsoft-novo\company_cliente\uploads, e copiam-se à mão para o web\uploads da app certa na antiga.
-->

---

<p class="passo-num">Cliente novo · Só programadores</p>

# Um repositório por cliente

<ol class="mt-4">
<li><em>Use this template</em> no GitHub → repositório <strong>privado</strong> <code>vsoft-industry-company-{cliente}</code></li>
<li>Mover do core: <code>interfaceERP/</code>, <code>etiquetas/</code>, fórmula própria → <code>strategies/</code></li>
<li>Namespaces: <code>company\interfaceERP</code> · <code>company\etiquetas</code> · <code>company\strategies</code></li>
<li>Logótipos <strong>da produção</strong> em <code>assets/</code> · cores em <code>assets/styles.css</code></li>
<li>No core: <code>git submodule add &lt;url&gt; company_&lt;cliente&gt;</code></li>
</ol>

<p class="hint">Os 17 clientes atuais já têm o seu. Isto é só para um cliente novo.</p>

<!--
O README do template tem a estrutura e os comandos git. Procurar referências antigas aos namespaces, por exemplo common\etiquetas\config\CLIENTE\GestaoEtiquetas. Os logótipos vêm sempre da instalação em produção, não do repositório.
-->

---
class: code-sm
---

<p class="passo-num">Cliente novo · params.php</p>

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

<p class="dim text-sm mt-2">O template já traz o bloco do <code>params-local.php</code> e o <code>.gitignore</code>.</p>

<!--
Um ficheiro com os valores de produção. O comentário de cada chave diz de onde vinha o valor antigo. O bloco do fim é o dos overrides de dev que vimos na parte 1: copiem-no tal como está.
-->

---
layout: center
---

<p class="meta">Parte 04</p>

# Atualizar um cliente

<div class="rule"></div>

<p class="lead">As versões seguintes · 5 passos · no teu PC ou no Builder</p>

<!--
Depois da migração, as versões seguintes. Duas maneiras de fazer o mesmo zip: à mão no vosso PC, ou no Builder, que corre as mesmas tasks.
-->

---

<p class="passo-num">Atualizar · Antes</p>

# Update ou pacote completo?

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<p class="code-label">Update</p>
<p class="dim text-sm">Só o que mudou · uns MB</p>
<ul class="checklist">
<li>Uma versão nova normal</li>
<li>Vai <strong>por cima</strong> da instalação</li>
</ul>
</div>
<div>
<p class="code-label accent">Pacote completo</p>
<p class="dim text-sm">Tudo · ~110 MB · é a parte 03</p>
<ul class="checklist">
<li>Primeira instalação e a <strong>migração para o 8.5</strong></li>
<li>Bibliotecas novas (<code>composer.lock</code> mudou)</li>
<li>O cliente passa a ter um módulo novo</li>
</ul>
</div>
</div>

<p class="hint mt-6">Na dúvida: pacote completo. Funciona sempre.</p>

<!--
O update leva só os ficheiros do git que mudaram, incluindo os da pasta do cliente. Não leva o vendor nem a config: por isso as bibliotecas novas e os módulos novos precisam do pacote completo. O Builder avisa quando o composer.lock mudou.
-->

---
class: resumo
---

<p class="passo-num">Atualizar · Resumo</p>

# Atualizar um cliente

| | Onde | O que fazer |
|---|---|---|
| 1 | PC | `task update CLIENTE=omelro DE=3.7.261023.01 MODULOS=fruits` |
| 2 | Servidor | Backup da BD e da pasta da aplicação |
| 3 | Servidor | Extrair o zip por cima, a substituir · apagar o que vier no `apagar.txt` |
| 4 | Servidor | `php yii migrate` |
| 5 | Servidor | `php yii cache/flush cache` · testar o login e o que a versão mudou |

<p class="dim text-sm mt-3"><code>DE</code> = a versão que o cliente tem, no menu do backend. No Builder, o passo 1 é <em>Gerar update</em>.</p>

<!--
O guia de bolso do update. Os slides seguintes são um por passo.
-->

---
class: big-code
---

<Trilho guia="atualizar" :passo="1" />

# Criar o update

<p class="onde">No teu PC, na pasta do projeto</p>

```powershell
task update CLIENTE=omelro DE=3.7.261023.01 MODULOS=fruits
```

<p class="resultado">Acaba com o zip em <code>dist\VSoftIndustry-omelro-v3.7.261023.01-to-v….zip</code></p>

<p class="hint"><code>DE</code> = a versão do cliente (menu do backend) · vai até à última. Os módulos: os do pacote.</p>

<!--
Vai buscar as versões novas ao GitHub sozinho. Para outra versão de destino: PARA=3.7.261027.01. Só vai o que está na tag. Os ficheiros apagados entre as duas versões não vão: no Builder ficam listados no apagar.txt, à mão não.
-->

---

<Trilho guia="atualizar" :passo="2" />

# Backup

<p class="onde">No servidor</p>

<ul class="checklist text-xl">
<li>Base de dados</li>
<li>Uma cópia da pasta da aplicação</li>
</ul>

<p class="resultado">Se correr mal: repor a cópia e a BD.</p>

---

<Trilho guia="atualizar" :passo="3" />

# Extrair por cima

<p class="onde">No servidor</p>

<ol class="text-xl">
<li>Extrair o zip <strong>para a pasta da aplicação</strong>, a substituir os ficheiros</li>
<li>Veio um <code>apagar.txt</code>? Apagar os ficheiros da lista</li>
</ol>

<p class="resultado">Não se renomeia nada, e não há config a preencher.</p>

<!--
O update não traz db.php nem os *-local.php: os que lá estão continuam.
-->

---
class: big-code
---

<Trilho guia="atualizar" :passo="4" />

# Migrar a base de dados

<p class="onde">No servidor, na pasta da aplicação</p>

```powershell
php yii migrate
```

<p class="resultado">Responder <strong>yes</strong>. Acaba com <code>Migrated up successfully.</code> (ou "No new migrations")</p>

---
class: big-code
---

<Trilho guia="atualizar" :passo="5" />

# Limpar a cache e testar

<p class="onde">No servidor, na pasta da aplicação</p>

```powershell
php yii cache/flush cache
```

<p class="resultado">Testar o login e o que a versão mudou. Se veio do Builder: <em>Confirmar aplicado</em>.</p>

---

<p class="passo-num">Builder · Só uma vez</p>

# Configurar o Builder

<div class="grid grid-cols-2 gap-8 mt-6">
<div>
<ol>
<li><strong>Configurações</strong>: organização GitHub + token → <em>Testar ligação</em></li>
<li><strong>Novo projeto</strong>: repositório <code>vsoft-plastics</code> → <em>Clonar</em></li>
<li><strong>Novo cliente</strong> e associar ao projeto</li>
<li>Na linha do cliente, <strong>⋮ → Pasta company</strong> e <strong>⋮ → Pacotes</strong></li>
</ol>
</div>
<div>

| Cliente | Pacotes |
|---|---|
| omelro | core + fruits |
| beiragel | core + beiragel |
| os outros | core |

<p class="hint mt-2">Sem pacotes escolhidos = <strong>todos</strong> os módulos.</p>

</div>
</div>

<!--
O token tem de ler o vsoft-plastics e os repositórios vsoft-industry-company-*: é com ele que o Builder vai buscar a pasta do cliente. A pasta company aparece sozinha se o nome do cliente bater certo com uma pasta livre. Os pacotes são os mesmos do MODULOS do task pacote.
-->

---

<p class="passo-num">Builder · Em vez do passo 1</p>

# Gerar no Builder

<ol class="mt-6 text-lg">
<li><em>Atualizar clone</em> (traz as versões novas)</li>
<li>Na linha do cliente: <strong>Gerar update</strong> (ou <strong>▼ → Gerar build completo</strong>, o pacote da parte 03)</li>
<li><strong>De</strong> já vem com a versão do cliente · <strong>Para</strong> = a nova → <strong>Gerar</strong></li>
<li>Descarregar o zip (e o <code>apagar.txt</code>, se houver)</li>
<li>Depois de instalar: <strong>Confirmar aplicado</strong></li>
</ol>

<p class="hint mt-6">O Builder corre as mesmas tasks: o zip é igual ao do teu PC.</p>

<!--
O Builder não sabe se o zip foi instalado: até Confirmar aplicado fica por validar, e a versão do cliente não muda. Na pré-visualização do update vêem-se os ficheiros que mudam, os apagados e o aviso de composer.lock mudou (aí, build completo). O Para também pode ser um commit de uma branch, para testar algo sem tag.
-->

---

# A seguir

<div class="grid grid-cols-3 gap-8 mt-10">
  <div class="step">
    <span class="step-num">01</span>
    <p class="step-title">Clientes no Builder</p>
    <p class="dim">Pasta company e pacotes de cada cliente</p>
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
Fica a faltar associar no Builder a pasta company e os pacotes de cada cliente (os updates já levam as alterações da pasta company), limpar as redes de segurança do PHP 8 e tirar o auth.json do repositório. Se encontrarem um passo errado, comentem na tarefa.
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
