Feature: Marvel Characters API - Crear Personaje (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Crear nuevo personaje - POST 
    * def timestamp = java.lang.System.currentTimeMillis()
    * def randomId = Math.floor(Math.random() * 999999)
    * def uniqueId = timestamp + '_' + randomId
    * def characterName = 'AutoTest Hero ' + uniqueId
    * def characterAlterego = 'Test User ' + uniqueId
    * def newCharacter = 
    """
    {
      "name": "#(characterName)",
      "alterego": "#(characterAlterego)",
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
    And match response.description == 'Heroe creado randomicamente'
    And match response.powers == ['Super Test', 'Automation']
    And print 'Personaje creado exitosamente:', response
    And print 'POST /api/characters ejecutado correctamente'

  Scenario: Intentar crear personaje con nombre duplicado - Error 400
    * def duplicateCharacter = 
    """
    {
      "name": "Iron Man",
      "alterego": "Tony Stark Duplicate",
      "description": "Intento de crear personaje duplicado",
      "powers": ["Duplicate Power"]
    }
    """
    Given url fullUrl
    And request duplicateCharacter
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.error == '#string'
    And match response.error == 'Character name already exists'
    And print 'Error esperado para nombre duplicado:', response
    And print 'POST /api/characters retornó 400 como se esperaba'

  Scenario: Intentar crear personaje con campos faltantes/vacíos - Error 400
    * def invalidCharacter = 
    """
    {
      "name": "",
      "alterego": "",
      "description": "",
      "powers": []
    }
    """
    Given url fullUrl
    And request invalidCharacter
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
    And print 'Error esperado para campos vacíos:', response
    And print 'POST /api/characters devolvio 400 para validación de campos requeridos'

  Scenario: Intentar crear personaje sin campos requeridos - Error 400
    * def emptyCharacter = {}
    Given url fullUrl
    And request emptyCharacter
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
    And print 'Error esperado para objeto vacío:', response
    And print 'POST /api/characters devolvio 400 para objeto sin campos'
