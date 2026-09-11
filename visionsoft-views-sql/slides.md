---
theme: default
title: Views SQL Versionadas
colorSchema: light
layout: cover
routerMode: hash
duration: 30min
timer: countdown
fonts:
  sans: 'Inter'
  serif: 'Inter'
  mono: 'JetBrains Mono'
  weights: '400,500,600,700'
---

<p class="meta">Formação Interna · Equipa de Desenvolvimento</p>

# Views SQL Versionadas

<div class="rule"></div>

<p class="lead">Mecanismo de versionamento de views SQL para integração.</p>

<p class="meta mt-10">VSoft Industry</p>

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
As views são de terceiros, uma por cliente. Quando o software evolui e pede novas colunas, nem todos os clientes atualizam ao mesmo tempo. Um SELECT fixo com todas as colunas parte assim que um cliente fica atrasado.
-->

---

# O que queremos

<ul class="plain-list mt-6">
<li>O código PHP pede sempre o conjunto de campos <strong>mais recente conhecido</strong>.</li>
<li>O mecanismo resolve, <strong>por cliente/versão</strong>, quais desses campos a view realmente tem em produção.</li>
<li>Campos que a view ainda não tem → preenchidos com <code>NULL</code> (ou um valor por defeito), <strong>sem a query deixar de funcionar</strong>.</li>
<li>Tudo isto sem tocar em cada <code>Commands.php</code> sempre que um cliente está atrasado — só quando a <em>especificação</em> evolui.</li>
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
    ├── ViewArmazens.php           # classe "default" / mais recente
    ├── ViewArmazens_v14.php       # versão v14 (delta face ao default)
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
    // Todos os campos que a view MAIS RECENTE deve ter
    protected function getAllFields(): array
    {
        return ['id', 'codigoCliente', 'nomeCliente', 'nifCliente', 'isAtivo'];
    }
    // Defaults para campos que uma versão antiga não tem
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

# Anatomia da classe *default* (2/2)

<p class="dim mt-1">Os dois métodos que identificam a view e a sua versão</p>

```php {2-5|7-10}
class ViewClientes extends AbstractViewModelVersion
{
    // Nome FÍSICO da view SQL — pode mudar entre versões
    public function getViewName(): string
    {
        return "ViewClientes";
    }

    // Chave em ConfigApp com a versão configurada do cliente
    public function getVersionConfigKey(): string
    {
        return "views_sql_viewclientes";
    }
}
```

<!--
Dois métodos. O nome físico da view, e a chave de configuração.
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
// '' = default/mais recente

$sql = $view->getSelectSql('isAtivo = 1');
```

  <ul class="plain-list mt-6">
    <li>Campo em falta na versão → <code>NULL</code> ou o valor de <code>getMissingFieldDefaults()</code></li>
    <li><strong>A query nunca parte</strong> por causa de uma coluna que o cliente ainda não tem</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">Cliente numa versão antiga, sem nifCliente</p>

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

<div class="rule mt-8"></div>

<p class="lead">Não criar classes de versão antiga especulativamente — só quando existir mesmo uma divergência documentada.</p>

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
layout: two-cols
class: code-sm
---

# `emailCliente` (G01.014)

<div class="pr-6 mt-4">

```php
protected function getAllFields(): array
{
    return [
        'id', 'codigoCliente',
        'nomeCliente', 'nifCliente',
        'emailCliente', // <- novo
        'isAtivo',
    ];
}
```

</div>

::right::

<div class="pl-8 mt-4">
  <p class="meta accent">1. Atualizar a classe default</p>
  <p class="mt-3 dim">O mesmo campo entra em <code>getAllFields()</code> <strong>e</strong> em <code>getFieldsInThisVersion()</code>.</p>
  <p class="mt-4 dim">A classe default representa <strong>sempre</strong> a versão mais recente conhecida.</p>
</div>

<!--
Rev G01.014 traz emailCliente. Atualizamos a classe default nos dois métodos ao mesmo tempo.
-->

---
layout: two-cols
class: code-sm
---

# 2. Congelar o estado anterior

<div class="pr-6 mt-4">

```php
// ViewClientes rev. G01.013
// - sem o campo emailCliente
class ViewClientes_v13
    extends ViewClientes
{
    protected function
        getFieldsInThisVersion(): array
    {
        return [
            'id', 'codigoCliente',
            'nomeCliente', 'nifCliente',
            'isAtivo',
        ];
    }
}
```

</div>

::right::

<div class="pl-8 mt-4">
  <ul class="plain-list">
    <li>Nome da classe <strong>tem de ser</strong> <code>{ClasseDefault}_{versão}</code></li>
    <li><strong>Atualizar</strong> <code>getViewName()</code> com a versão correspondente</li>
    <li>Não mexer na factory — resolve <code>_{versão}</code> automaticamente</li>
    <li>Configurar <code>views_sql_viewclientes = 13</code> em ConfigApp para os clientes ainda na revisão antiga</li>
  </ul>
</div>

<!--
Uma subclasse congela o estado anterior. O nome tem de seguir a convenção. Nunca mexer no nome físico da view.
-->

---

# As 3 secções, resumidas

| Secção | Quando usar |
|---|---|
| **Criar um pacote** | A view ainda não existe neste mecanismo |
| **Criar uma versão** | A especificação evolui — a view *default* ganha/perde colunas |
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

<p class="lead">Cenário: descobre-se, depois de facto, que um cliente está preso a uma revisão anterior à que já está mapeada como default</p>

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

<p class="lead">a partir de <code>common/interfaceERP/*/Commands.php</code></p>

---
layout: two-cols
class: code-sm
---

# Chamada + exemplo real

<div class="pr-6 mt-4">
<p class="code-label">Genérico</p>

```php
use ...\Clientes\ViewClientesFactory;

$view = ViewClientesFactory::create(
    $versao
);
$sql = $view->getSelectSql('isAtivo = 1');

$linhas = $this->queryAll($sql);
```

</div>

::right::

<div class="pl-8 mt-4">
<p class="code-label accent">PEARLIZPLAS\Commands</p>

```php
$sql = ViewArmazensFactory::create(
    AppCache::getConfig(
        'views_sql_viewarmazens'
    )
)->getSelectSql('isAtivo = 1');

return $this->fixEncoding(
    $this->queryAll($sql)
);
```

</div>

<!--
Sempre o mesmo padrão: factory, versão configurada, getSelectSql, executar.
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
    <p class="mt-2 dim">Factory <strong>lança exceção</strong> — nunca assume o default silenciosamente</p>
  </div>
</div>

<!--
A versão vem do ConfigApp, por cliente. Vazio é default. Preenchido sem classe correspondente é erro, de propósito.
-->

---

# Outros métodos úteis

<ul class="plain-list mt-6">
<li><code>getFieldsAsArray()</code> — array pronto para SQL, ex: <code>["id", "nomeArmazem", "0 AS usaLocalizacoes"]</code></li>
<li><code>getFieldsAsSelectString($showColumns = [])</code> — a mesma lista como string; <code>$showColumns</code> filtra só as colunas pedidas</li>
<li><code>getFieldsAsJsonElements($showColumns = [])</code> — formato <code>"chave": "valor"</code> para respostas <em>ajax</em></li>
<li><code>getSelectSql($where = '', $showColumns = [])</code> — atalho <code>SELECT ... FROM ... [WHERE ...]</code> completo</li>
</ul>

<div class="rule mt-8"></div>

<p class="lead"><strong>Usar sempre que possível</strong>, em vez de montar SQL à mão.</p>

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

<ul class="plain-list mt-2">
<li>Descobre <strong>automaticamente</strong> qualquer pasta em <code>common/models/views/</code> com um <code>*Factory.php</code> — não é preciso registar nada.</li>
<li>Para cada entidade, consulta o <code>INFORMATION_SCHEMA.COLUMNS</code> real da base de dados do cliente e compara com o que a versão configurada espera.</li>
</ul>

<div class="grid grid-cols-2 gap-2 mt-4">
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

<p class="dim mt-3 pr-20">Primeiro sítio a consultar ao integrar um cliente novo ou suspeitar de uma view desatualizada. Hoje já são <strong>20 entidades</strong> versionadas.</p>

<!--
A página de teste é o primeiro sítio a consultar. Descoberta automática, comparação real ao schema do cliente.
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
<li><em>(só quando necessário)</em> <code>{Entidade}_{versão}.php</code> — estende a classe default, sobrepõe só <code>getFieldsInThisVersion()</code>.</li>
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

<p class="meta">Obrigado</p>

# Perguntas?

<div class="rule"></div>

<p class="lead">Docs em <code>common/models/views/README.md</code></p>

<div class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-6">
  <img src="/logo.svg" class="h-7 object-contain" alt="Visionsoft" />
</div>

<!--
Obrigado. O README tem todos os detalhes e exemplos que vimos hoje.
-->
