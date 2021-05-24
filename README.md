# Customer success balancing

Olá, meu nome é Daniel Landi Santos e essa é a minha solução do teste proposto.
A solução foi feita utilizando ***ruby 2.7.2***, e deixei uma rake também pronta para executar os testes, bastando rodar `rake test`.

## Sobre a solução

Avaliando o teste e procurando manter a simplicidade na solução, implementei apenas uma classe com características de model, para modelar o Customer Success e auxiliar na distribuição e contagem de quantos clientes eles estão atendendo.
O restante da solução foi implementado mesmo na classe base proposta pelo teste, a *CustomerSuccessBalancing*.
Eu gosto de separar os passos em outros métodos, para facilitar tanto a  leitura quanto a manutenção do código, por isso no método `execute` da classe, existem apenas chamadas para os métodos que realmente fazem a magia acontecer.
Eu utilizei recursos de filtro e ordenação da própria linguagem, que são eficientes o bastante pelo proposto, e tornam o código simples de entender.
Acho que a única coisa que talvez deva ser melhor explicada é que na hora de distribuir os clientes pelos CSs, vali-me da premissa de que todos os CSs tem níveis diferentes para poder executar uma busca suficientemente eficiente para a distribuição (linhas 46 e 49 do arquivo customer_success_balancing.rb).

## Considerações finais
Agradeço a oportunidade e foi muito uma experiência legal fazer esse teste.

Até logo!