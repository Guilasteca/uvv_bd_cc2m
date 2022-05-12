Questão 01:


SELECT numero_departamento,round (avg(salario),2) 
AS média_salarial 
FROM funcionario 
GROUP BY  numero_departamento 
ORDER BY numero_departamento;



Questão 02:


SELECT sexo, round (avg(salario),2) 
AS média_salarial 
FROM funcionario  
GROUP BY  sexo;


Questão 03:


SELECT concat(primeiro_nome, nome_meio, ultimo_nome) 
AS nome_completo, data_nascimento, year(current_timestamp())-year(data_nascimento) 
AS idade, salario, d.nome_departamento 
FROM funcionario f 
INNER JOIN departamento d 
ON f.numero_departamento = d.numero_departamento ;



Questão 04:


SELECT DISTINCT concat(f1.primeiro_nome, f1.nome_meio, f1.ultimo_nome) 
AS nome_completo, year(current_timestamp())-year(f1.data_nascimento) 
AS idade, f1.salario 
AS salaraio_atual, if(f2.salario >= 35000, f2.salario * 1.15, f2.salario * 1.20) 
AS salario_reajustado 
FROM funcionario f1
INNER JOIN funcionario f2 ON (f1.cpf = f2.cpf);



Questão 05:


SELECT DISTINCT f1.primeiro_nome 
AS funcionarios, f2.primeiro_nome 
AS gerentes, d.nome_departamento, f1.salario 
FROM funcionario f1 
INNER JOIN funcionario f2 
ON (f1.cpf_supervisor = f2.cpf) 
INNER JOIN departamento d ON (f1.numero_departamento = d.numero_departamento)
ORDER BY nome_departamento, salario DESC;



Questão 06:


SELECT  DISTINCT concat(primeiro_nome, nome_meio, ultimo_nome) 
AS nome_funcionario, numero_departamento, concat(d.nome_dependente, f.nome_meio, f.ultimo_nome) 
AS nome_dependente, year(current_timestamp())-year(d.data_nascimento) 
AS idade_dependente, if(d.sexo = "M","Masculino","Feminino") 
AS sexo 
FROM funcionario f, dependente 
INNER JOIN dependente d 
WHERE f.cpf = d.cpf_funcionario;



Questão 07:


SELECT concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) 
AS nome_completo, f.salario,  part.nome_departamento 
FROM funcionario 
AS f INNER join departamento part 
ON (part.numero_departamento = f.numero_departamento) left 
JOIN dependente depart 
ON (depart.cpf_funcionario = f.cpf) 
WHERE depart.nome_dependente IS NULL;



Questão 08:


SELECT distinct numero_departamento, trabalha_em.numero_projeto, concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) 
AS nome_funcionario,horas 
FROM funcionario 
AS f
INNER JOIN trabalha_em 
ON f.cpf = trabalha_em.cpf_funcionario 
ORDER BY numero_departamento;



Questão 09:


SELECT  sum(t.horas) 
AS horas_totais, nome_projeto, nome_departamento 
FROM trabalha_em t  
INNER JOIN projeto p 
ON p.numero_projeto = t.numero_projeto 
INNER JOIN departamento d on d.numero_departamento = p.numero_departamento 
WHERE t.numero_projeto = t.numero_projeto  
GROUP BY t.numero_projeto, p.nome_projeto, d.nome_departamento;



Questão 10:


SELECT numero_departamento, round (avg(salario),2) 
AS média_salarial 
FROM funcionario 
GROUP BY numero_departamento 
ORDER BY numero_departamento;



Questão 11:


SELECT CONCAT(f.primeiro_nome, nome_meio, ultimo_nome) 
AS nome_funcionario, projeto.nome_projeto,(trabalha_em.horas * 50)
AS valor
FROM ((funcionario AS f inner join trabalha_em on f.cpf = trabalha_em.cpf_funcionario) inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto);



Questão 12:


SELECT CONCAT(primeiro_nome, nome_meio, ultimo_nome) 
AS funcionario, d.nome_departamento, p.nome_projeto, horas 
FROM departamento d inner JOIN projeto p ON (d.numero_departamento = p.numero_departamento) 
INNER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto) inner JOIN funcionario f ON (t.cpf_funcionario = f.cpf) WHERE t.horas = 0;



Questão 13:


SELECT DISTINCT concat(primeiro_nome, nome_meio, ultimo_nome) 
AS nome, sexo, year(current_timestamp())-year(data_nascimento) 
AS idade 
FROM funcionario union
SELECT DISTINCT concat(d.nome_dependente, f.nome_meio, f.ultimo_nome) AS nome, d.sexo, year(current_timestamp())-year(d.data_nascimento) 
AS idade
FROM dependente d
INNER JOIN funcionario f ON (f.cpf = d.cpf_funcionario)
ORDER BY idade DESC;



Questão 14:


SELECT f.numero_departamento, count(*) as qnt_empregados 
FROM funcionario f, departamento d
WHERE f.numero_departamento = d.numero_departamento
GROUP BY  f.numero_departamento;



Questão 15:


SELECT distinct concat(f.primeiro_nome, f.nome_meio, f.ultimo_nome) AS nome_completo, f.numero_departamento, p.nome_projeto
FROM funcionario f
INNER JOIN trabalha_em te ON (f.cpf = te.cpf_funcionario)
left outer JOIN projeto p ON (p.numero_projeto = te.numero_projeto AND f.cpf = te.cpf_funcionario AND te.horas > 0)
ORDER BY nome_projeto;
