Feature: Marvel Characters API - Obtener Personajes (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Obtener todos los personajes - GET /api/characters
    Given url fullUrl
    When method get
    Then status 200
    And match response == '#array'
    And print 'Total de personajes encontrados:', response.length
    And print 'Response:', response
    And print 'GET /api/characters ejecutado exitosamente'
