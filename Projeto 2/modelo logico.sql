-- Criação do Banco de Dados
CREATE DATABASE flexempresta;
USE flexempresta;

-- Tabela: TabelaColaboradores (primeiro porque é referenciada por outras tabelas)
CREATE TABLE TabelaColaboradores (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    NomeColaborador VARCHAR(100) NOT NULL,
    CPFColaborador VARCHAR(14) NOT NULL,
    TelefoneColaborador VARCHAR(15),
    Salario DECIMAL(10, 2),
    EmailColaborador VARCHAR(100),
    Cargo VARCHAR(50),
    id_departamento INT
);

-- Tabela: TabelaDepartamento
CREATE TABLE TabelaDepartamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    NomeDepartamento VARCHAR(100) NOT NULL,
    NumeroDepartamento INT NOT NULL,
    NomeColaboradorGerente VARCHAR(100),
    id_colaborador INT,
    FOREIGN KEY (id_colaborador) REFERENCES TabelaColaboradores(id_colaborador)
);

-- Ajuste da chave estrangeira para referenciar TabelaDepartamento (agora que ambas as tabelas existem)
ALTER TABLE TabelaColaboradores
    ADD CONSTRAINT FK_Departamento
    FOREIGN KEY (id_departamento) REFERENCES TabelaDepartamento(id_departamento);

-- Tabela: TabelaClientes
CREATE TABLE TabelaClientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    Telefones VARCHAR(100),
    Email VARCHAR(100),
    EnderecoCompleto VARCHAR(255),
    DataNascimento DATE,
    id_colaborador INT,
    FOREIGN KEY (id_colaborador) REFERENCES TabelaColaboradores(id_colaborador)
);

-- Tabela: TabelaScoreCredito
CREATE TABLE TabelaScoreCredito (
    id_score INT AUTO_INCREMENT PRIMARY KEY,
    DataConsulta DATE NOT NULL,
    Fonte VARCHAR(100) NOT NULL,
    Pontuacao INT NOT NULL,
    Justificativa TEXT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES TabelaClientes(id_cliente)
);

-- Tabela: TabelaEmprestimo
CREATE TABLE TabelaEmprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    NomeCliente VARCHAR(100) NOT NULL,
    Prazo INT NOT NULL,
    DataInicio DATE NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(50),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES TabelaClientes(id_cliente)
);

-- Tabela: TabelaPagamentos
CREATE TABLE TabelaPagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    DataPagamento DATE NOT NULL,
    Status VARCHAR(50),
    Valor DECIMAL(10, 2) NOT NULL,
    id_emprestimo INT,
    FOREIGN KEY (id_emprestimo) REFERENCES TabelaEmprestimo(id_emprestimo)
);

-- Tabela: TabelaConta
CREATE TABLE TabelaConta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY,
    NumeroConta VARCHAR(50) NOT NULL,
    TipoConta VARCHAR(50) NOT NULL,
    DataAbertura DATE NOT NULL
);

-- Tabela: TabelaClienteConta
CREATE TABLE TabelaClienteConta (
    id_conta INT,
    id_cliente INT,
    NomeCliente VARCHAR(100),
    TipoConta VARCHAR(50),
    PRIMARY KEY (id_conta, id_cliente),
    FOREIGN KEY (id_conta) REFERENCES TabelaConta(id_conta),
    FOREIGN KEY (id_cliente) REFERENCES TabelaClientes(id_cliente)
);

-- Exibir todos os clientes existentes na tabela TabelaClientes
SELECT id_cliente, Nome
FROM TabelaClientes;


-- Tentativa de inserir um empréstimo para um cliente não existente (exemplo: id_cliente = 999)
INSERT INTO TabelaEmprestimo (NomeCliente, Prazo, DataInicio, Tipo, Valor, Status, id_cliente)
VALUES ('Carlos Souza', 36, '2024-01-15', 'Imobiliário', 200000.00, 'Pendente', 999);

