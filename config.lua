-- Configuração do LuaAI
local config = {
    -- Configurações gerais
    version = "1.0.0",
    debug = false,
    verbose = true,
    
    -- Configurações de análise
    analysis = {
        max_complexity = 10,
        max_function_length = 50,
        max_nesting_depth = 4,
        enforce_local_vars = true,
        require_comments = false,
        check_performance = true
    },
    
    -- Configurações de sugestões
    suggestions = {
        show_examples = true,
        show_fixes = true,
        group_by_type = true,
        max_suggestions = 20
    },
    
    -- Configurações de templates
    templates = {
        use_tabs = false,
        indent_size = 4,
        line_ending = "\n",
        author_name = "LuaAI",
        default_module_pattern = "PascalCase"
    },
    
    -- Configurações de relatórios
    reports = {
        format = "text", -- text, json, html
        include_metrics = true,
        include_suggestions = true,
        include_examples = true,
        save_to_file = true
    },
    
    -- Padrões personalizados
    patterns = {
        -- Variáveis que devem ser sempre globais
        allowed_globals = {
            "_G", "_VERSION", "arg", "package", "require",
            "print", "error", "assert", "type", "next", "pairs", "ipairs"
        },
        
        -- Funções que indicam boa prática
        good_practices = {
            "pcall", "xpcall", "assert", "type",
            "setmetatable", "getmetatable"
        },
        
        -- Padrões de nomenclatura
        naming = {
            constants = "UPPER_CASE",
            variables = "snake_case", 
            functions = "snake_case",
            modules = "PascalCase",
            classes = "PascalCase"
        }
    },
    
    -- Configurações de performance
    performance = {
        warn_string_concat_in_loops = true,
        warn_global_access = true,
        warn_deep_nesting = true,
        suggest_local_caching = true,
        max_loop_nesting = 3
    },
    
    -- Mensagens personalizáveis
    messages = {
        syntax_error = "Erro de sintaxe detectado",
        no_local_vars = "Considere usar variáveis locais",
        deep_nesting = "Aninhamento muito profundo detectado",
        long_function = "Função muito longa, considere dividir",
        no_error_handling = "Adicione tratamento de erros",
        performance_issue = "Possível problema de performance",
        good_code = "Código bem estruturado!",
        analysis_complete = "Análise concluída"
    },
    
    -- Configurações de saída
    output = {
        use_colors = true,
        show_progress = true,
        timestamp_reports = true,
        max_line_length = 80
    }
}

return config
