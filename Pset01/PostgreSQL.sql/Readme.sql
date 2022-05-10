
CREATE TABLE elmasri.Funcionario (
                cpf CHAR NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereço VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor VARCHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario PRIMARY KEY (cpf)
);


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento PRIMARY KEY (numero_departamento)
);


CREATE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento ASC );

CREATE UNIQUE INDEX departamento_idx1
 ON elmasri.departamento
 ( nome_departamento );

CREATE INDEX departamento_idx2
 ON elmasri.departamento
 ( cpf_gerente );

CLUSTER departamento_idx2 ON departamento;

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);


CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto ASC );

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);


/*
Warning: Column types mismatch in the following column mapping(s):
        cpf: CHAR -- cpf_supervisor: VARCHAR(11)
*/
ALTER TABLE elmasri.Funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.Funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.Funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.Funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.Funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk1
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
