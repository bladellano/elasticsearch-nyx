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
