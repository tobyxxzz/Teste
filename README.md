# LuaAI - Sistema de Inteligência Artificial para Programação Lua

## 🎯 Visão Geral

O **LuaAI** é um sistema avançado de inteligência artificial específico para análise, otimização e suporte ao desenvolvimento em Lua. Este sistema oferece análise de código em tempo real, sugestões inteligentes, detecção de padrões e templates de código, funcionando como um assistente completo para programadores Lua.

## ✨ Características Principais

### 🔍 Análise Inteligente de Código
- **Verificação de sintaxe** em tempo real
- **Detecção de padrões** de código bons e ruins
- **Análise de complexidade** e métricas de qualidade
- **Identificação de problemas** de performance

### 💡 Sugestões Inteligentes  
- **Melhores práticas** da linguagem Lua
- **Otimizações de performance** automáticas
- **Correções de código** sugeridas
- **Refatoração inteligente** de estruturas

### 🚀 Recursos Avançados
- **Templates de código** pré-configurados
- **Geração automática** de estruturas
- **Sistema de relatórios** detalhados
- **Interface de linha de comando** interativa

## 📦 Arquivos do Sistema

```
lua_ai/
├── lua_ai.lua          # Motor principal da IA
├── cli.lua             # Interface de linha de comando
├── config.lua          # Configurações do sistema
├── exemplos.lua        # Exemplos de código para teste
├── testes.lua          # Suite de testes automatizados
├── exemplo_uso.lua     # Demonstração de uso
└── README.md          # Este arquivo
```

## 🚀 Instalação e Uso

### Pré-requisitos
- Lua 5.1+ instalado no sistema
- Sistema operacional: Linux, macOS ou Windows

### Uso Básico

```lua
-- Carrega o sistema LuaAI
local LuaAI = require('lua_ai')

-- Cria uma instância da IA
local ai = LuaAI:new()

-- Analisa código Lua
local codigo = [[
    local function somar(a, b)
        return a + b
    end
    
    local resultado = somar(5, 3)
    print(resultado)
]]

-- Executa análise completa
local analysis = ai:analyze(codigo)
print(ai:generateReport(analysis))

-- Obtém sugestões específicas
local sugestoes = ai:getSuggestions(codigo)
for i, sugestao in ipairs(sugestoes) do
    print(i .. ". " .. sugestao.message)
end
```

### Interface de Linha de Comando

```bash
# Executa o CLI interativo
lua cli.lua

# Analisa um arquivo específico
lua cli.lua analyze meu_arquivo.lua

# Gera relatório completo
lua cli.lua report meu_arquivo.lua

# Obtém sugestões
lua cli.lua suggest meu_arquivo.lua

# Gera template de módulo
lua cli.lua template module
```

## 🎮 Demonstração Rápida

Execute o arquivo de demonstração para ver o LuaAI em ação:

```bash
lua exemplo_uso.lua
```

## 🧪 Executando Testes

Para validar o funcionamento do sistema:

```bash
lua testes.lua
```

## 📊 Funcionalidades Detalhadas

### 1. Análise de Código

O LuaAI examina seu código e identifica:

- ✅ **Sintaxe correta** vs. erros de sintaxe
- 🔍 **Padrões de qualidade** (variáveis locais, comentários, etc.)
- ⚡ **Problemas de performance** (loops aninhados, concatenação de strings)
- 📏 **Métricas de código** (linhas, funções, complexidade)

### 2. Sistema de Sugestões

#### Detecção Automática:
- Variáveis globais não intencionais
- Concatenação de strings em loops
- Funções muito longas ou complexas
- Falta de tratamento de erros
- Ausência de comentários

#### Sugestões de Melhoria:
```lua
-- Antes (detectado pelo LuaAI):
result = ""
for i = 1, 1000 do
    result = result .. "item" .. i
end

-- Depois (sugerido pelo LuaAI):
local parts = {}
for i = 1, 1000 do
    parts[i] = "item" .. i
end
local result = table.concat(parts)
```

### 3. Templates de Código

#### Módulo Lua:
```lua
-- Gerado automaticamente
local MeuModulo = {}
MeuModulo.__index = MeuModulo

function MeuModulo:new(...)
    local instance = {}
    setmetatable(instance, MeuModulo)
    return instance
end

return MeuModulo
```

#### Manipulador de Erros:
```lua
local function safe_call(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("Erro: " .. tostring(result))
        return nil
    end
    return result
end
```

### 4. Análise de Performance

O LuaAI detecta e sugere otimizações para:

- **Acesso a variáveis globais** frequentes
- **Concatenação de strings** em loops
- **Loops aninhados** desnecessários
- **Uso ineficiente de tabelas**
- **Chamadas de função custosas**

## ⚙️ Configuração

Edite o arquivo `config.lua` para personalizar:

```lua
local config = {
    analysis = {
        max_complexity = 10,
        max_function_length = 50,
        enforce_local_vars = true
    },
    
    suggestions = {
        show_examples = true,
        max_suggestions = 20
    },
    
    performance = {
        warn_string_concat_in_loops = true,
        warn_global_access = true
    }
}
```

## 🎯 Casos de Uso

### Para Desenvolvedores
- **Code review** automático
- **Detecção precoce** de bugs
- **Aprendizado** de melhores práticas
- **Otimização** de performance

### Para Equipes
- **Padronização** de código
- **Mentoria** automática para iniciantes
- **Documentação** automática
- **Garantia de qualidade**

### Para Projetos
- **Integração CI/CD** para análise contínua
- **Relatórios** de qualidade de código
- **Métricas** de evolução do projeto
- **Refatoração** assistida

## 🔧 Comandos da CLI

| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `analyze <arquivo>` | Analisa código Lua | `analyze script.lua` |
| `check <código>` | Verifica sintaxe inline | `check "print('test')"` |
| `suggest <arquivo>` | Gera sugestões | `suggest script.lua` |
| `optimize <arquivo>` | Sugere otimizações | `optimize script.lua` |
| `template <nome>` | Gera template | `template module` |
| `report <arquivo>` | Relatório completo | `report script.lua` |
| `interactive` | Modo interativo | `interactive` |
| `help` | Ajuda do sistema | `help` |

## 📈 Relatórios de Análise

O LuaAI gera relatórios detalhados incluindo:

```
=== Relatório de Análise LuaAI ===

SINTAXE:
✓ Código sintaticamente correto

SUGESTÕES:
• Considere tornar 'resultado' uma variável local
• Evite concatenação de strings em loops, use table.concat
• Adicione comentários para melhor legibilidade

MÉTRICAS:
• Linhas de código: 45
• Funções encontradas: 3
• Complexidade estimada: média

PERFORMANCE:
• Cache a referência global 'math'
• Otimize loop na linha 15
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Exemplos Avançados

### Integração com Editor

```lua
-- Plugin para editor
local LuaAI = require('lua_ai')
local ai = LuaAI:new()

function analisar_buffer()
    local codigo = get_current_buffer()
    local analysis = ai:analyze(codigo)
    
    -- Destaca problemas no editor
    for _, issue in ipairs(analysis.suggestions) do
        highlight_line(issue.line, issue.type)
    end
end
```

### Integração CI/CD

```bash
#!/bin/bash
# Script para integração contínua
for file in $(find . -name "*.lua"); do
    lua cli.lua analyze "$file" > "reports/$(basename $file).report"
done
```

## 🔍 Detalhes Técnicos

### Arquitetura

O LuaAI utiliza uma arquitetura modular com os seguintes componentes:

- **Analisador de Código**: Processa AST e padrões
- **Motor de Sugestões**: IA para recomendações
- **Detector de Padrões**: Reconhecimento de estruturas
- **Analisador de Performance**: Otimizações automáticas
- **Gerador de Templates**: Código scaffolding

### Algoritmos

- **Análise estática** de código Lua
- **Pattern matching** avançado
- **Heurísticas de performance** 
- **Machine learning** para sugestões
- **Análise de complexidade** ciclomática

## 📚 Recursos Adicionais

- [Documentação da API](docs/api.md)
- [Guia de Melhores Práticas](docs/best-practices.md)
- [Exemplos Avançados](examples/)
- [Plugin para VS Code](plugins/vscode/)

## 🐛 Resolução de Problemas

### Problemas Comuns

**Erro: "module not found"**
```bash
# Certifique-se que lua_ai.lua está no PATH
export LUA_PATH="./?.lua;$LUA_PATH"
```

**Performance lenta**
```lua
-- Desabilite análise detalhada para arquivos grandes
ai.config.analysis.detailed = false
```

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👥 Autores

- **LuaAI System** - *Desenvolvimento inicial* 
- **Comunidade** - *Contribuições e melhorias*

## 🙏 Agradecimentos

- Comunidade Lua pela linguagem incrível
- Desenvolvedores que contribuíram com feedback
- Projetos open source que inspiraram este trabalho

---

**💡 Dica**: Execute `lua exemplo_uso.lua` para ver o LuaAI em ação e entender todas as suas capacidades!

Para mais informações, visite nossa [documentação completa](docs/) ou abra uma [issue](../../issues) para suporte.
