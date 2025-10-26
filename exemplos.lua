-- Exemplos de código para testar o LuaAI

-- Arquivo: exemplo_bom.lua
-- Este é um exemplo de código Lua bem estruturado
local exemplo_bom = [[
-- Módulo de calculadora
local Calculator = {}
Calculator.__index = Calculator

-- Cria uma nova instância da calculadora
function Calculator:new()
    local instance = {
        history = {},
        precision = 2
    }
    setmetatable(instance, Calculator)
    return instance
end

-- Adiciona dois números
function Calculator:add(a, b)
    assert(type(a) == "number", "Primeiro argumento deve ser um número")
    assert(type(b) == "number", "Segundo argumento deve ser um número")
    
    local result = a + b
    self:_add_to_history("add", a, b, result)
    return result
end

-- Método privado para adicionar ao histórico
function Calculator:_add_to_history(operation, a, b, result)
    table.insert(self.history, {
        operation = operation,
        operands = {a, b},
        result = result,
        timestamp = os.time()
    })
end

-- Obtém o histórico de operações
function Calculator:get_history()
    return self.history
end

return Calculator
]]

-- Arquivo: exemplo_ruim.lua  
-- Este código tem vários problemas que o LuaAI deve detectar
local exemplo_ruim = [[
contador = 0  -- variável global desnecessária

function processar()  -- sem comentários
    resultado = ""  -- outra global
    for i = 1, 1000 do
        for j = 1, 100 do  -- loops aninhados
            for k = 1, 10 do  -- muito aninhamento
                if i > 500 then
                    if j > 50 then
                        if k > 5 then
                            resultado = resultado .. "item" .. i .. j .. k  -- concatenação em loop
                            contador = contador + 1
                        end
                    end
                end
            end
        end
    end
    return resultado  -- sem validação
end

x = processar()  -- sem tratamento de erro
y = math.sin(x)  -- x é string, vai dar erro
print(y)
]]

-- Arquivo: exemplo_performance.lua
-- Código com problemas de performance
local exemplo_performance = [[
-- Problemas de performance comuns

-- Acesso excessivo a globais
function calcular_distancia(pontos)
    resultado = {}
    for i = 1, #pontos do
        for j = i + 1, #pontos do
            dx = math.abs(pontos[i].x - pontos[j].x)
            dy = math.abs(pontos[i].y - pontos[j].y)
            dist = math.sqrt(dx * dx + dy * dy)
            table.insert(resultado, dist)
        end
    end
    return resultado
end

-- Concatenação de strings em loop
function gerar_relatorio(dados)
    html = "<html><body>"
    for i = 1, #dados do
        html = html .. "<p>" .. dados[i].nome .. ": " .. dados[i].valor .. "</p>"
    end
    html = html .. "</body></html>"
    return html
end

-- Uso ineficiente de tabelas
function processar_lista(lista)
    nova_lista = {}
    for i = 1, #lista do
        if lista[i] > 0 then
            nova_lista[#nova_lista + 1] = lista[i] * 2
        end
    end
    return nova_lista
end
]]

-- Arquivo: exemplo_correto.lua
-- Versão corrigida dos problemas acima
local exemplo_correto = [[
-- Versões otimizadas das funções

local function calcular_distancia(pontos)
    -- Cache das funções matemáticas para melhor performance
    local math_abs = math.abs
    local math_sqrt = math.sqrt
    
    local resultado = {}
    local count = 0
    
    for i = 1, #pontos do
        for j = i + 1, #pontos do
            local dx = math_abs(pontos[i].x - pontos[j].x)
            local dy = math_abs(pontos[i].y - pontos[j].y)
            local dist = math_sqrt(dx * dx + dy * dy)
            
            count = count + 1
            resultado[count] = dist
        end
    end
    
    return resultado
end

local function gerar_relatorio(dados)
    -- Usa table.concat para melhor performance
    local partes = {"<html><body>"}
    local count = 1
    
    for i = 1, #dados do
        count = count + 1
        partes[count] = "<p>" .. dados[i].nome .. ": " .. dados[i].valor .. "</p>"
    end
    
    count = count + 1
    partes[count] = "</body></html>"
    
    return table.concat(partes)
end

local function processar_lista(lista)
    -- Pré-aloca a tabela para melhor performance
    local nova_lista = {}
    local count = 0
    
    for i = 1, #lista do
        local valor = lista[i]
        if valor > 0 then
            count = count + 1
            nova_lista[count] = valor * 2
        end
    end
    
    return nova_lista
end
]]

-- Exporta os exemplos
local exemplos = {
    bom = exemplo_bom,
    ruim = exemplo_ruim,
    performance = exemplo_performance,
    correto = exemplo_correto
}

-- Função para salvar exemplos em arquivos
local function salvar_exemplos()
    for nome, codigo in pairs(exemplos) do
        local arquivo = io.open("exemplo_" .. nome .. ".lua", "w")
        if arquivo then
            arquivo:write(codigo)
            arquivo:close()
            print("Exemplo salvo: exemplo_" .. nome .. ".lua")
        end
    end
end

return {
    exemplos = exemplos,
    salvar_exemplos = salvar_exemplos
}
