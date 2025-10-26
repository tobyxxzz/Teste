#!/usr/bin/env lua

--[[
    Exemplo de uso do LuaAI
    
    Este arquivo demonstra como usar o sistema de IA para análise de código Lua
--]]

-- Carrega o sistema LuaAI
local LuaAI = require('lua_ai')

-- Cria uma instância da IA
local ai = LuaAI:new()

print("=== LuaAI - Demonstração ===\n")

-- Código de exemplo para análise
local exemplo_codigo = [[
-- Exemplo de código Lua com alguns problemas
global_var = "isso deveria ser local"

function funcao_muito_longa()
    for i = 1, 100 do
        for j = 1, 100 do
            resultado = resultado .. "texto" .. i .. j
            if i > 50 then
                if j > 50 then
                    if resultado then
                        print("processando...")
                    end
                end
            end
        end
    end
end

function calcular(a, b)
    return a + b
end

x = calcular(5, 3)
y = math.sin(x) * math.cos(x)
]]

print("1. ANÁLISE DO CÓDIGO:")
print("=" .. string.rep("=", 40))
local analysis = ai:analyze(exemplo_codigo)

-- Gera e exibe o relatório
print(ai:generateReport(analysis))
print()

print("2. SUGESTÕES DETALHADAS:")
print("=" .. string.rep("=", 40))
local suggestions = ai:getSuggestions(exemplo_codigo)
for i, suggestion in ipairs(suggestions) do
    print(i .. ". " .. suggestion.message)
    if suggestion.fix then
        print("   Correção: " .. suggestion.fix)
    end
    if suggestion.example then
        print("   Exemplo: " .. suggestion.example)
    end
    print()
end

print("3. OTIMIZAÇÕES DE PERFORMANCE:")
print("=" .. string.rep("=", 40))
local optimizations = ai:optimizeCode(exemplo_codigo)
for i, opt in ipairs(optimizations) do
    print(i .. ". " .. opt.message)
    if opt.suggestion then
        print("   Sugestão: " .. opt.suggestion)
    end
    print()
end

print("4. GERAÇÃO DE TEMPLATES:")
print("=" .. string.rep("=", 40))

print("Template de Módulo:")
print(ai:generateCode("module", {name = "MeuModulo"}))
print()

print("Template de Manipulador de Erros:")
print(ai:generateCode("error_handler"))
print()

print("5. SISTEMA DE AJUDA:")
print("=" .. string.rep("=", 40))
print(ai:help())

-- Exemplo de uso interativo
print("\n6. EXEMPLO INTERATIVO:")
print("=" .. string.rep("=", 40))

local function analisar_codigo_usuario(codigo)
    print("Analisando código do usuário...")
    local user_analysis = ai:analyze(codigo)
    print(ai:generateReport(user_analysis))
    
    local user_suggestions = ai:getSuggestions(codigo)
    if #user_suggestions > 0 then
        print("\nSugestões:")
        for i, sug in ipairs(user_suggestions) do
            print("• " .. sug.message)
        end
    end
end

-- Código de exemplo do usuário (com problemas intencionais)
local codigo_usuario = [[
name = "João"
age = 25

function process()
    result = ""
    for i = 1, 1000 do
        result = result .. name .. " tem " .. age .. " anos. "
    end
    return result
end

data = process()
print(data)
]]

analisar_codigo_usuario(codigo_usuario)

print("\n=== Demonstração Concluída ===")
print("O LuaAI analisou o código, identificou problemas e ofereceu soluções!")
print("Use 'lua exemplo_uso.lua' para executar esta demonstração.")
