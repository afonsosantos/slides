---
theme: default
title: Views SQL Versionadas
colorSchema: light
layout: cover
routerMode: hash
duration: 30min
timer: countdown
addons:
  - slidev-addon-second-screen
fonts:
  sans: 'Poppins'
  serif: 'Poppins'
  mono: 'JetBrains Mono'
  weights: '400,500,600,700'
---

<p class="meta">Formação Interna · Equipa de Desenvolvimento</p>

# Views SQL Versionadas

<div class="rule"></div>

<p class="lead">Mecanismo de versionamento de views SQL para integração.</p>

<p class="meta mt-10">VSoft Industry</p>
<p class="meta-sub mt-2">Afonso Santos · afonso.santos@visionsoft.pt · 16/09/2026</p>

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/logo.svg" class="h-8 object-contain" alt="Visionsoft" />
</div>

<!--
Hoje vamos falar sobre o mecanismo de versionamento das views SQL de integração. Porque existe, como está estruturado, e como o usamos no dia-a-dia.
-->

---
layout: section
---

<p class="meta">Parte 01</p>

# O Problema

<div class="rule"></div>

---

# As views são geridas por terceiros

<ul class="plain-list mt-6">
<li>As <em>views</em> de integração (<code>ViewArtigos</code>, <code>ViewArmazens</code>, <code>ViewEncomendasCliente</code>, ...) são criadas e mantidas por <strong>empresas terceiras</strong>.</li>
<li>O software evolui e passa a pedir <strong>novas colunas</strong>.</li>
<li><strong>Nem todos os clientes atualizam a view ao mesmo tempo.</strong></li>
</ul>

<div class="rule mt-8"></div>

<p class="code-label">Sem mecanismo de versões</p>

```sql
SELECT id, codigoArtigo, nomeArtigo, ..., aux1, aux2 FROM ViewArtigos
-- Invalid column name 'aux1' (cliente ainda não tem a coluna)
```

<p class="dim mt-4">A query deixa de funcionar assim que um cliente fica atrasado numa coluna nova.</p>

<!--
As views são de terceiros, uma por cliente. Quando o software evolui e pede novas colunas, nem todos os clientes atualizam ao mesmo tempo. Um SELECT fixo com todas as colunas deixa de funcionar assim que um cliente fica atrasado.
-->

---

# O que queremos

<ul class="plain-list mt-6">
<li>O código PHP pede sempre o conjunto de campos <strong>mais recente conhecido</strong>.</li>
<li>O mecanismo resolve, <strong>por cliente/versão</strong>, quais desses campos a view realmente tem em produção.</li>
<li>Campos que a view ainda não tem → preenchidos com <code>NULL</code> (ou um valor por defeito), <strong>sem a query deixar de funcionar</strong>.</li>
<li>Tudo isto sem tocar em cada <code>Commands.php</code> sempre que um cliente está atrasado — só quando a especificação evolui.</li>
</ul>

<!--
O objetivo: pedir sempre o mais recente, resolver por versão o que a view suporta, e nunca partir a query.
-->

---
layout: section
---

<p class="meta">Parte 02</p>

# Estrutura de um "pacote" de view

<div class="rule"></div>

---

# Uma pasta por entidade

<p class="code-label">common/models/views/Armazens/</p>

```
common/models/views/
├── AbstractViewModelVersion.php   # motor comum (não duplicar)
├── AbstractViewModelFactory.php   # base comum das factories
└── Armazens/
    ├── ViewArmazens.php           # classe "default" / revisão inicial
    ├── ViewArmazens_v14.php       # revisão v14 (delta face ao default)
    └── ViewArmazensFactory.php    # factory desta entidade
```

<div class="rule mt-8"></div>

<p class="lead">Duas peças partilhadas por todas as entidades — nunca duplicar.</p>

<!--
Cada entidade tem a sua pasta. Duas peças são partilhadas por todas: o motor e a factory base.
-->

---
class: code-sm
---

# Anatomia da classe *default* (1/2)

<p class="dim mt-1">Os três métodos que definem os campos da view</p>

```php {3-7|8-12|13-17}
class ViewClientes extends AbstractViewModelVersion
{
    // Todos os campos que esta versão da view declara
    protected function getAllFields(): array
    {
        return ['id', 'codigoCliente', 'nomeCliente', 'nifCliente', 'isAtivo'];
    }
    // Defaults para campos que a view real não tem
    protected function getMissingFieldDefaults(): array
    {
        return ['nifCliente' => ''];
    }
    // Campos que ESTA versão realmente suporta
    protected function getFieldsInThisVersion(): array
    {
        return ['id', 'codigoCliente', 'nomeCliente', 'nifCliente', 'isAtivo'];
    }
}
```

<!--
Três métodos. Todos os campos, os defaults para os que faltam, e os campos desta versão.
-->

---
class: code-sm
---

# Anatomia da classe *default* (2/2)

<p class="dim mt-1">Identificação da view, chave de configuração, e campos garantidos</p>

```php {3-7|8-12|13-17}
class ViewClientes extends AbstractViewModelVersion
{
    // Nome FÍSICO da view SQL — nem sempre igual ao da classe
    public function getViewName(): string
    {
        return "ViewClientes"; // ViewUtilizadores -> "ViewUsers"
    }
    // Chave em ConfigApp com a versão configurada do cliente
    public function getVersionConfigKey(): string
    {
        return "views_sql_viewclientes";
    }
    // Campos que a app assume como garantidos
    protected function getRequiredFields(): array
    {
        return ['id', 'codigoCliente', 'nomeCliente', 'isAtivo'];
    }
}
```

<!--
O nome físico da view, a chave de configuração, e os campos obrigatórios — estes últimos só servem para a página de teste assinalar versões que não os fornecem.
-->

---
layout: two-cols-header
---

# O que o motor faz por nós

<div class="rule"></div>

::left::

<div class="pr-10">
  <p class="meta">Chamamos sempre o mesmo código</p>

```php
$view = ViewClientesFactory::create($versao);
// '' = classe default (revisão inicial)

$sql = $view->getSelectSql('isAtivo = 1');
```

  <ul class="plain-list mt-6">
    <li>Campo em falta na versão → <code>NULL</code> ou o valor de <code>getMissingFieldDefaults()</code></li>
    <li><strong>A query nunca deixa de funcionar</strong> por causa de uma coluna que o cliente ainda não tem</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">Cliente numa revisão sem nifCliente</p>

```sql
SELECT
  id, codigoCliente, nomeCliente,
  '' AS nifCliente, isAtivo
FROM ViewClientes
WHERE isAtivo = 1
```
</div>

<!--
O mesmo código de chamada, para qualquer cliente. O motor gera o SQL certo consoante a versão configurada.
-->

---
layout: section
---

<p class="meta">Parte 03</p>

# Como criar uma nova view (pacote)

<div class="rule"></div>

<p class="lead">Cenário: a view ainda não existe no mecanismo</p>

---

# Passos

<ol class="mt-6 text-lg">
<li>Criar a pasta <code>common/models/views/{Entidade}/</code>.</li>
<li v-click>Criar a classe <strong>default</strong> <code>{Entidade}.php</code>, com todos os métodos (slide anterior).</li>
<li v-click>Criar a <strong>factory</strong> <code>{Entidade}Factory.php</code> — só indica a classe default.</li>
<li v-click>Adicionar a chave <code>views_sql_view{entidade}</code> em <code>RequisitosMinimos::KEYS</code>, categoria "Views SQL" → "Versões".</li>
<li v-click>Nos <code>Commands.php</code> (ou em <code>AbstractCommandsERP</code>), substituir o <code>FROM ViewX</code> literal por <code>{Entidade}Factory::create(...)->getSelectSql(...)</code>.</li>
</ol>

<!--
Cinco passos. Pasta, classe default, factory, chave de config, e trocar o FROM literal pelo mecanismo.
-->

---
layout: two-cols
class: code-sm
---

# A factory

<div class="pr-6 mt-4">

```php
class ViewClientesFactory
    extends AbstractViewModelFactory
{
    protected static function
        defaultClass(): string
    {
        return ViewClientes::class;
    }
}
```

</div>

::right::

<div class="pl-8 mt-4">
  <p class="meta">Nada a registar</p>
  <p class="mt-3 dim">A pasta já é suficiente para o mecanismo funcionar.</p>
  <p class="mt-3 dim">A página <code>test-views/index</code> descobre automaticamente qualquer pasta com um <code>*Factory.php</code>.</p>
</div>

<!--
A factory só indica a classe default. Não é preciso registar o pacote nalgum sítio central.
-->

---
layout: section
---

<p class="meta">Parte 04</p>

# Como criar uma nova versão

<div class="rule"></div>

<p class="lead">Cenário: o Manual de Integração avança — a especificação ganha uma coluna nova</p>

---
class: code-sm
---

# `emailCliente` (G01.014)

<p class="dim mt-1">A classe default fica intacta — a revisão nova é uma classe nova</p>

```php {1|3-8|10-13}
class ViewClientes_v14 extends ViewClientes
{
    // rev. G01.014: acrescenta emailCliente
    protected function getAllFields(): array
    {
        return ['id', 'codigoCliente', 'nomeCliente',
                'nifCliente', 'emailCliente', 'isAtivo'];
    }

    protected function getFieldsInThisVersion(): array
    {
        return $this->getAllFields();
    }
}
```

<p class="lead mt-6">Só se <strong>acrescenta</strong>: a default fica congelada na revisão inicial e a factory continua a apontar para ela.</p>

<!--
Rev G01.014 traz emailCliente. Não mexemos na classe default: criamos a classe da revisão nova, com o campo acrescentado.
-->

---

# Apontar os clientes à nova revisão

<ul class="plain-list mt-6">
<li>Nome da classe <strong>tem de ser</strong> <code>{ClasseDefault}_{versão}</code> — a factory resolve-o automaticamente.</li>
<li><strong>Não mexer na factory</strong> — aponta sempre para a classe inicial, sem versão.</li>
<li>Se o nome físico da view mudou nesta revisão, sobrepor também <code>getViewName()</code>.</li>
<li>Configurar <code>views_sql_viewclientes = 14</code> em ConfigApp, para os clientes que já têm a view atualizada.</li>
<li>Clientes ainda na revisão inicial → chave vazia → classe default, <strong>sem alterações</strong>.</li>
</ul>

<div class="rule mt-8"></div>

<p class="lead">A classe default e a factory mantêm-se intactas para sempre.</p>

<!--
A classe nova segue a convenção de nome, a factory resolve sozinha, e a configuração do cliente diz qual usar. Quem está na revisão inicial não precisa de nada.
-->

---

# As 3 secções, resumidas

| Secção | Quando usar |
|---|---|
| **Criar um pacote** | A view ainda não existe neste mecanismo |
| **Criar uma versão** | O Manual de Integração avança — a revisão nova ganha/perde colunas |
| **Adicionar versão antiga** | Descobre-se que um cliente já configurado está preso a uma revisão anterior |

<!--
Três cenários distintos, mesma mecânica por baixo.
-->

---
layout: section
---

<p class="meta">Parte 05</p>

# Como adicionar uma versão antiga

<div class="rule"></div>

<p class="lead">Cenário: descobre-se, depois de facto, que um cliente está preso a uma revisão <strong>anterior</strong> à classe default</p>

---
layout: two-cols
class: code-sm
---

# Mesma mecânica

<div class="pr-6 mt-4">

```php
// ViewClientes rev. v10
// - sem o campo nifCliente
class ViewClientes_v10
    extends ViewClientes
{
    protected function
        getFieldsInThisVersion(): array
    {
        return [
            'id', 'codigoCliente',
            'nomeCliente', 'isAtivo',
        ];
    }
}
```

</div>

::right::

<div class="pl-8 mt-8">
  <p class="meta">Só sobrepõe getFieldsInThisVersion()</p>
  <p class="mt-3 dim">Qualquer campo que exista em <code>getAllFields()</code> mas não aqui é automaticamente substituído por <code>NULL</code> (ou o valor de <code>getMissingFieldDefaults()</code>).</p>
</div>

<!--
Exatamente a mesma técnica de congelar uma versão — só que reativa, quando se descobre o atraso depois de facto.
-->

---
layout: section
---

<p class="meta">Parte 06</p>

# Como usar

<div class="rule"></div>

<p class="lead">na implementação genérica ou específica de cliente</p>

---
layout: two-cols-header
class: code-sm
---

# Chamada + exemplo real

<div class="rule"></div>

::left::

<div class="pr-6 mt-4">
<p class="code-label">AbstractCommandsERP.php <span class="dim">(genérico, todos os clientes)</span></p>

```php
protected function getClientesSql(): string
{
    $versao = AppCache::getConfig(
        'views_sql_viewclientes'
    );

    return ViewClientesFactory::create($versao)
        ->getSelectSql('isAtivo = 1');
}
```

<p class="mt-2 dim">Vive na classe base — herdado por quem não tem override.</p>
</div>

::right::

<div class="pl-8 mt-4">
<p class="code-label accent">PEARLIZPLAS\Commands.php <span class="dim">(override específico)</span></p>

```php
protected function getArmazens(): array
{
    $sql = ViewArmazensFactory::create(
        AppCache::getConfig(
            'views_sql_viewarmazens'
        )
    )->getSelectSql('isAtivo = 1');

    return $this->fixEncoding(
        $this->queryAll($sql)
    );
}
```

<p class="mt-2 dim">Só o extra do cliente (aqui, <code>fixEncoding</code>) muda.</p>
</div>

<!--
Sempre o mesmo padrão: factory, versão configurada, getSelectSql. A diferença entre genérico e específico não está no mecanismo — está em onde o método vive: na classe base ou num override do cliente.
-->

---

# De onde vem a versão a usar

<ul class="plain-list mt-6">
<li>Configuração <strong>por instalação</strong>, guardada em <code>ConfigApp</code>, configurável em Configurações do Projeto → <strong>Views SQL → Versões</strong>.</li>
<li>Lida através de <code>AppCache::getConfig('views_sql_view{entidade}')</code> (cache invalidada automaticamente ao gravar).</li>
<li>O valor é só o <strong>número da revisão</strong> (ex: <code>14</code>) → resolve para <code>{ClasseDefault}_v14</code>.</li>
</ul>

<div class="rule mt-8"></div>

<div class="grid grid-cols-2 gap-6">
  <div>
    <p class="meta">Chave vazia / não definida</p>
    <p class="mt-2 dim">Factory devolve a classe <strong>default</strong></p>
  </div>
  <div>
    <p class="meta accent">Chave preenchida, sem classe correspondente</p>
    <p class="mt-2 dim">Factory lança <code>InvalidViewException</code> — nunca assume o default silenciosamente</p>
  </div>
</div>

<!--
A versão vem do ConfigApp, por cliente. Vazio é default. Preenchido sem classe correspondente é erro, de propósito.
-->

---
layout: two-cols-header
---

# Outros métodos úteis

<div class="rule"></div>

::left::

<ul class="plain-list mt-4 pr-6">
<li><code>getFieldsAsArray()</code> — array pronto para SQL, ex: <code>["id", "nomeArmazem", "0 AS usaLocalizacoes"]</code></li>
<li><code>getFieldsAsSelectString($showColumns = [])</code> — a mesma lista como string; <code>$showColumns</code> filtra só as colunas pedidas</li>
<li><code>getFieldsAsJsonElements($showColumns = [])</code> — formato <code>"chave": "valor"</code> para respostas <em>ajax</em></li>
</ul>

::right::

<ul class="plain-list mt-4 pl-6">
<li><code>getSelectSql($where = '', $showColumns = [])</code> — atalho <code>SELECT ... FROM ... [WHERE ...]</code> completo</li>
<li><code>ViewNamesTrait</code> — só o <strong>nome</strong> da view já resolvido (ex: <code>viewClientesName()</code>), para <em>JOINs</em> e SQL montado à mão</li>
</ul>

<p class="lead mt-6"><strong>Usar sempre que possível</strong>, em vez de montar SQL à mão.</p>

<!--
getSelectSql é o atalho a usar quase sempre.
-->

---
layout: section
---

<p class="meta">Parte 07</p>

# Página de teste automática

<div class="rule"></div>

<p class="lead"><code>backend/web/index.php?r=test-views/index</code></p>

---

# `test-views/index`

<ul class="plain-list mt-1">
<li>Descobre <strong>automaticamente</strong> qualquer pasta em <code>common/models/views/</code> com um <code>*Factory.php</code> — não é preciso registar nada.</li>
<li>Para cada entidade, consulta o <code>INFORMATION_SCHEMA.COLUMNS</code> real do cliente e compara com o que a versão configurada espera.</li>
</ul>

<div class="grid grid-cols-2 gap-2 mt-3">
  <div class="status-card status-ok">
    <p class="status-name">OK</p>
    <p class="status-desc">Todos os campos da versão existem na view real</p>
  </div>
  <div class="status-card status-danger">
    <p class="status-name">VIEW MISSING</p>
    <p class="status-desc">A view não existe (ou não está visível)</p>
  </div>
  <div class="status-card status-warn">
    <p class="status-name">COLUMN MISSING</p>
    <p class="status-desc">Faltam colunas não-obrigatórias desta versão</p>
  </div>
  <div class="status-card status-danger">
    <p class="status-name">MANDATORY FIELD MISSING</p>
    <p class="status-desc">Falta um campo que a app assume como garantido</p>
  </div>
</div>

<p class="dim mt-2 pr-20">Primeiro sítio a consultar ao integrar um cliente novo. Hoje já são <strong>20 entidades</strong> versionadas.</p>

<!--
A página de teste é o primeiro sítio a consultar. Descoberta automática, comparação real ao schema do cliente (demonstração com a página de teste).
-->

---
layout: section
---

# Checklist rápida ao criar um pacote

<div class="rule"></div>

---

<ol class="mt-8 text-lg">
<li><code>common/models/views/{Entidade}/{Entidade}.php</code> — classe <em>default</em>, estende <code>AbstractViewModelVersion</code>.</li>
<li><code>common/models/views/{Entidade}/{Entidade}Factory.php</code> — estende <code>AbstractViewModelFactory</code>, só define <code>defaultClass()</code>.</li>
<li><em>(a cada revisão do manual)</em> <code>{Entidade}_{versão}.php</code> — estende a classe default; a default nunca muda.</li>
<li>Nova chave em <code>RequisitosMinimos::KEYS</code>, categoria "Views SQL" → "Versões", nome <code>views_sql_view{entidade}</code>.</li>
<li>Nos <code>Commands.php</code> do cliente (ou em <code>AbstractCommandsERP</code>), trocar o <code>FROM ViewX</code> literal pelo <code>{Entidade}Factory::create(...)->getSelectSql(...)</code>.</li>
</ol>

<!--
Cinco passos, sempre os mesmos.
-->

---
layout: end
class: text-center
---

# Perguntas?

<div class="rule"></div>

<p class="lead">Docs em <code>common/models/views/README.md</code></p>

<div class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-6">
  <img src="/logo.svg" class="h-7 object-contain" alt="Visionsoft" />
</div>

<!--
Obrigado. O README tem todos os detalhes e exemplos que vimos hoje.
-->
