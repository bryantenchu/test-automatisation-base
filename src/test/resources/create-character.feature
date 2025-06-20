Feature: Marvel Characters API - Crear Personaje (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Crear nuevo personaje - POST 
    * def randomId = Math.floor(Math.random() * 999999)
    * def newCharacter = 
    """
    {
      "name": "Test hero #(randomId)",
      "alterego": "Test usuerio #(randomId)",
      "description": "Heroe creado randomicamente",
      "powers": ["Super Test", "Automation"]
    }
    """
    Given url fullUrl
    And request newCharacter
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.name == '#string'
    And match response.alterego == '#string'
    And match response.description == 'Heroe creado atomaticamente'
    And match response.powers == ['Super Test', 'Automation']
    And print 'Personaje creado exitosamente:', response
    And print 'POST /api/characters ejecutado correctamente'
