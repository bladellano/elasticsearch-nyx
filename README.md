
# 🔍 Drupal + Elasticsearch: Exemplo de Integração

Este projeto demonstra a integração entre **Drupal**, **Search API** e **Elasticsearch** utilizando conteúdo gerado com o módulo **Devel**.

## ✅ Requisitos

- Módulos:
  - `search_api`
  - `elasticsearch_connector`
  - `devel`
  - `devel_generate`
- Docker

## 🐳 Subir o container Elasticsearch local

```bash
docker run -d --name elasticsearch \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  -p 9200:9200 \
  docker.elastic.co/elasticsearch/elasticsearch:7.17.20
```

## ⚙️ Configuração no Drupal

### 1. Habilitar os módulos necessários

```bash
drush en search_api elasticsearch_connector devel devel_generate -y
```

### 2. Gerar conteúdo de teste

```bash
drush generate-content 500 --types=article
```

### 3. Criar servidor Elasticsearch no Search API

- Nome: `Elasticsearch Local`
- Tipo: Elasticsearch 7.x
- URL: `http://localhost:9200`

### 4. Criar index no Search API

- Nome: `Articles`
- Entidade: Node > Article
- Adicionar campos:
  - Título
  - Corpo
- Configurar processadores:
  - Fulltext
  - HTML filter
  - Language

### 5. Criar View para pesquisa

- Nome: `Listagem de artigos pesquisáveis`
- Tipo: **Bloco**
- Mostrar: Search API index > Articles
- Adicionar campos:
  - Título (datasource)
  - Corpo (datasource)
- Filtros expostos:
  - Título
  - Corpo
  - Fulltext search (campo global)

### 6. Aparência do site

```bash
drush theme:enable gin
drush config:set system.theme default gin -y
```

### 7. Adicionar bloco de view

- Vá em **Estrutura > Layout**
- Adicione o bloco da view **Listagem de artigos pesquisáveis** no **Cabeçalho**

### 8. Desabilitar exibição de conteúdos no frontpage

- Acesse: `/admin/structure/views/view/frontpage`
- Desative a view ou remova o caminho `<front>`
