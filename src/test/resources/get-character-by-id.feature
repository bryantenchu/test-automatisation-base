Feature: Marvel Characters API - Obtener Personaje por ID (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Obtener personaje por ID exitoso - GET /api/characters/1
    Given url fullUrl + '/1'
    When method get
    Then status 200
    And match response.id == 1
    And match response.name == '#string'
    And match response.alterego == '#string'
    And match response.description == '#string'
    And match response.powers == '#array'
    And print 'Personaje encontrado:', response
    And print 'GET /api/characters/1 ejecutado exitosamente'
