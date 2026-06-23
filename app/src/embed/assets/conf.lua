function love.conf(t)
    t.window.title = "tic-tac-toe " -- Nome do seu jogo
    t.window.width = 360             -- Largura da tela
    t.window.height = 640            -- Altura da tela
    t.modules.physics = false        -- Desativa o que não vamos usar
    t.modules.audio = false
end
