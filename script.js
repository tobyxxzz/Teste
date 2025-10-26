class NumberGuessingGame {
    constructor() {
        this.targetNumber = null;
        this.attempts = 0;
        this.guessHistory = [];
        this.bestScore = localStorage.getItem('bestScore') || null;
        
        this.initializeElements();
        this.bindEvents();
        this.startNewGame();
        this.updateBestScore();
    }
    
    initializeElements() {
        this.guessInput = document.getElementById('guess-input');
        this.submitBtn = document.getElementById('submit-btn');
        this.newGameBtn = document.getElementById('new-game-btn');
        this.messageDiv = document.getElementById('message');
        this.attemptsSpan = document.getElementById('attempts');
        this.bestScoreSpan = document.getElementById('best-score');
        this.historyDiv = document.getElementById('history');
    }
    
    bindEvents() {
        this.submitBtn.addEventListener('click', () => this.makeGuess());
        this.newGameBtn.addEventListener('click', () => this.startNewGame());
        this.guessInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                this.makeGuess();
            }
        });
        
        // Validação de input em tempo real
        this.guessInput.addEventListener('input', (e) => {
            const value = parseInt(e.target.value);
            if (value < 1 || value > 100) {
                e.target.style.borderColor = '#e53e3e';
            } else {
                e.target.style.borderColor = '#e2e8f0';
            }
        });
    }
    
    startNewGame() {
        this.targetNumber = Math.floor(Math.random() * 100) + 1;
        this.attempts = 0;
        this.guessHistory = [];
        
        this.updateDisplay();
        this.clearMessage();
        this.clearHistory();
        this.enableInput();
        
        this.newGameBtn.style.display = 'none';
        
        console.log('🎯 Novo jogo iniciado! Número secreto:', this.targetNumber); // Para debug
    }
    
    makeGuess() {
        const guess = parseInt(this.guessInput.value);
        
        // Validação
        if (!this.isValidGuess(guess)) {
            this.showMessage('🚨 Por favor, digite um número entre 1 e 100!', 'warning');
            return;
        }
        
        // Verificar se já foi tentado
        if (this.guessHistory.some(h => h.guess === guess)) {
            this.showMessage('🔄 Você já tentou esse número!', 'warning');
            return;
        }
        
        this.attempts++;
        this.processGuess(guess);
        this.updateDisplay();
        this.guessInput.value = '';
        this.guessInput.focus();
    }
    
    isValidGuess(guess) {
        return !isNaN(guess) && guess >= 1 && guess <= 100;
    }
    
    processGuess(guess) {
        const result = this.compareGuess(guess);
        this.guessHistory.push({ guess, result });
        
        if (result === 'correct') {
            this.handleWin();
        } else {
            this.handleIncorrectGuess(guess, result);
        }
        
        this.updateHistory();
    }
    
    compareGuess(guess) {
        if (guess === this.targetNumber) {
            return 'correct';
        } else if (guess < this.targetNumber) {
            return 'too-low';
        } else {
            return 'too-high';
        }
    }
    
    handleWin() {
        const messages = [
            '🎉 Parabéns! Você acertou!',
            '🏆 Excelente! Número correto!',
            '🎯 Bulls-eye! Você conseguiu!',
            '⭐ Fantástico! Acertou em cheio!'
        ];
        
        const randomMessage = messages[Math.floor(Math.random() * messages.length)];
        this.showMessage(
            `${randomMessage}<br>O número era <strong>${this.targetNumber}</strong>!<br>Você conseguiu em ${this.attempts} tentativa${this.attempts !== 1 ? 's' : ''}!`,
            'success'
        );
        
        this.updateBestScore();
        this.disableInput();
        this.newGameBtn.style.display = 'block';
    }
    
    handleIncorrectGuess(guess, result) {
        const difference = Math.abs(guess - this.targetNumber);
        let message = '';
        let hint = '';
        
        if (result === 'too-high') {
            message = `📉 ${guess} é muito alto!`;
        } else {
            message = `📈 ${guess} é muito baixo!`;
        }
        
        // Dicas baseadas na proximidade
        if (difference <= 5) {
            hint = ' 🔥 Você está muito perto!';
        } else if (difference <= 10) {
            hint = ' 🌡️ Está quente!';
        } else if (difference <= 20) {
            hint = ' 🌤️ Está morno...';
        } else {
            hint = ' 🧊 Está frio!';
        }
        
        this.showMessage(message + hint, result === 'too-high' ? 'warning' : 'info');
    }
    
    updateDisplay() {
        this.attemptsSpan.textContent = this.attempts;
    }
    
    updateBestScore() {
        if (this.targetNumber && this.guessHistory.length > 0 && 
            this.guessHistory[this.guessHistory.length - 1].result === 'correct') {
            
            if (!this.bestScore || this.attempts < parseInt(this.bestScore)) {
                this.bestScore = this.attempts;
                localStorage.setItem('bestScore', this.bestScore);
            }
        }
        
        this.bestScoreSpan.textContent = this.bestScore || '-';
    }
    
    updateHistory() {
        this.historyDiv.innerHTML = this.guessHistory
            .map(h => `<span class="history-item ${h.result}">${h.guess}</span>`)
            .join('');
    }
    
    clearHistory() {
        this.historyDiv.innerHTML = '';
    }
    
    showMessage(message, type) {
        this.messageDiv.innerHTML = message;
        this.messageDiv.className = `message ${type}`;
    }
    
    clearMessage() {
        this.messageDiv.innerHTML = '';
        this.messageDiv.className = 'message';
    }
    
    enableInput() {
        this.guessInput.disabled = false;
        this.submitBtn.disabled = false;
        this.guessInput.focus();
    }
    
    disableInput() {
        this.guessInput.disabled = true;
        this.submitBtn.disabled = true;
    }
}

// Inicializar o jogo quando a página carregar
document.addEventListener('DOMContentLoaded', () => {
    const game = new NumberGuessingGame();
    
    // Easter egg: Konami code
    let konamiCode = [];
    const konami = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65]; // ↑↑↓↓←→←→BA
    
    document.addEventListener('keydown', (e) => {
        konamiCode.push(e.keyCode);
        if (konamiCode.length > 10) {
            konamiCode.shift();
        }
        
        if (konamiCode.join(',') === konami.join(',')) {
            alert('🎮 Easter Egg encontrado! O número secreto é: ' + game.targetNumber);
            konamiCode = [];
        }
    });
});

// Adicionar algumas funcionalidades extras
document.addEventListener('DOMContentLoaded', () => {
    // Adicionar efeito de partículas na vitória
    function createConfetti() {
        const colors = ['#667eea', '#764ba2', '#48bb78', '#ed8936', '#4299e1'];
        
        for (let i = 0; i < 50; i++) {
            const confetti = document.createElement('div');
            confetti.style.position = 'fixed';
            confetti.style.left = Math.random() * 100 + 'vw';
            confetti.style.top = '-10px';
            confetti.style.width = '10px';
            confetti.style.height = '10px';
            confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
            confetti.style.pointerEvents = 'none';
            confetti.style.borderRadius = '50%';
            confetti.style.zIndex = '9999';
            
            document.body.appendChild(confetti);
            
            const animation = confetti.animate([
                { transform: 'translateY(-10px) rotate(0deg)', opacity: 1 },
                { transform: `translateY(100vh) rotate(720deg)`, opacity: 0 }
            ], {
                duration: Math.random() * 3000 + 2000,
                easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
            });
            
            animation.onfinish = () => confetti.remove();
        }
    }
    
    // Observar mudanças na mensagem para detectar vitória
    const messageDiv = document.getElementById('message');
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.target.classList.contains('success')) {
                createConfetti();
            }
        });
    });
    
    observer.observe(messageDiv, {
        attributes: true,
        attributeFilter: ['class']
    });
});
