# Projeto Drupal com Elasticsearch

## Configuração inicial

1. Clone o arquivo `.env.example` para `.env`:
   ```bash
   cp .env.example .env
   ```

2. Adicione a seguinte URL ao arquivo `/etc/hosts`:
   ```
   127.0.0.1 drupal-elasticsearch.docker.local
   ```

3. Certifique-se de que o `Make` esteja instalado no sistema.

## Comandos principais

### Instalar o projeto
Para instalar o projeto de forma prática, execute:
```bash
make install
```

### Remover o projeto
Para remover o projeto completamente, execute:
```bash
make prune
```

## Mais informações
Para mais detalhes sobre os comandos disponíveis, consulte o arquivo `docker.mk`.

---

## Exercício Pós-Instalação

Após subir este projeto, siga os passos abaixo:

1. **Apagar/Desabilitar Server e Index do Server**:
   - Acesse a configuração do Elasticsearch no Drupal e remova ou desative o servidor e o índice existentes.

2. **Criar um novo Server e Index**:
   - Configure um novo servidor e índice no módulo de pesquisa.

3. **Criar um tipo de conteúdo novo**:
   - Adicione um tipo de conteúdo com apenas dois campos: **Title** e **Body**.

4. **Gerar conteúdos com o módulo Devel**:
   - Use o módulo `Devel` e `Devel Generate` para criar conteúdos automaticamente.

5. **Configurar campos e processadores**:
   - Configure os campos e processadores no índice de pesquisa.

6. **Criar uma View**:
   - Crie uma View para listar os itens pesquisáveis.

Boa sorte com o exercício e aproveite o projeto!

## Como testar

Para executar os testes com PHPUnit no container Docker:

1. Instale as dependências de desenvolvimento (caso ainda não tenha feito):

   ```bash
   docker-compose exec app composer require --dev phpunit/phpunit
   ```

2. Execute os testes:

   ```bash
   docker-compose exec app vendor/bin/phpunit --colors=always
   ```

## Configuração do VSCode para Xdebug

Para usar o Xdebug no Docker com o VSCode, crie ou atualize o arquivo `.vscode/launch.json` com:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "XDebug (Docker)",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "${workspaceRoot}"
            }
        }
    ]
}
```

## Observações

Precisei modificar algumas partes padrões do Drupal para poder ter uma página inicial limpar somente para exibir o bloco de pesquisa.

View:
- No admin `http://drupal-elasticsearch.docker.local/admin/structure/views/view/frontpage/edit/page_1`

- Modifiquei o filtro para não exibir - `Conteúdo Publicado:(=Nāo)`

Tema:
- Defini o Gin 4.1.0 como tema padrão.

Layout de bloco:
- Adicionei o bloco `Todos os artigos (elasticsearch): Block` (`http://drupal-elasticsearch.docker.local/admin/structure/block`) no cabeçalho, como primeiro item.

TESTE
