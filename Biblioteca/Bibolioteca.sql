-- Estrutura do banco de dados "Biblioteca"

-- Criação do banco
DROP DATABASE biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Tabela Autores
CREATE TABLE Autores (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  nacionalidade VARCHAR(50),
  data_nascimento DATE,
  livros_total INT
) ENGINE = InnoDB;

-- Tabela Usuarios
CREATE TABLE Usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL unique,
  telefone VARCHAR(45),
  data_cadastro DATE,
  total_emprestimos INT
) ENGINE = InnoDB;

-- Tabela Livros
CREATE TABLE Livros (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  ano_publicacao INT,
  genero VARCHAR(45),
  descricao TEXT,
  disponibilidade VARCHAR(45),
  quantidade_exemplares INT,
  id_autores BIGINT UNSIGNED,
  
  CONSTRAINT fk_Livros_Autores FOREIGN KEY (id_autores) REFERENCES Autores(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

-- Tabela Emprestimos
CREATE TABLE Emprestimos (
  id SERIAL PRIMARY KEY,
  id_usuario BIGINT UNSIGNED,
  id_livro BIGINT UNSIGNED,
  data_emprestimo DATE NOT NULL,
  data_devolucao_real DATE NOT NULL,
  status VARCHAR(45),
  atraso_dias INT,
  
  CONSTRAINT fk_Emprestimos_Usuarios FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Emprestimos_Livros FOREIGN KEY (id_livro) REFERENCES Livros(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela Reservas
CREATE TABLE Reservas (
  id SERIAL PRIMARY KEY,
  id_usuario BIGINT UNSIGNED,
  id_livro BIGINT UNSIGNED,
  data_reserva DATE NOT NULL,
  status_reserva VARCHAR(45) NOT NULL,
  posicao_na_fila INT,
  
  CONSTRAINT fk_Reservas_Usuarios FOREIGN KEY (id_usuario) REFERENCES Usuarios (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Reservas_Livros FOREIGN KEY (id_livro) REFERENCES Livros (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

