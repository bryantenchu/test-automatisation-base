Feature: Marvel Characters API - Actualizar Personaje (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Actualizar personaje existente - PUT exitoso
    * def characterId = 1
    * def updateUrl = fullUrl + '/' + characterId
    * def updatedCharacter = 
    """
    {
      "name": "Iron Man",
      "alterego": "Tony Stark",
      "description": "Updated description for testing",
      "powers": ["Armor", "Flight", "AI Assistant"]
    }
    """
    Given url updateUrl
    And request updatedCharacter
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match response.id == 1
    And match response.name == 'Iron Man'
    And match response.alterego == 'Tony Stark'
    And match response.description == 'Updated description for testing'
    And match response.powers == ['Armor', 'Flight', 'AI Assistant']
    And print 'Personaje actualizado exitosamente:', response
    And print 'PUT /api/characters/1 ejecutado correctamente'

  Scenario: Intentar actualizar personaje inexistente - Error 404
    * def nonExistentId = 999
    * def updateUrl = fullUrl + '/' + nonExistentId
    * def updatedCharacter = 
    """
    {
      "name": "Non Existent Hero",
      "alterego": "Test User",
      "description": "This should fail",
      "powers": ["Test Power"]
    }
    """
    Given url updateUrl
    And request updatedCharacter
    And header Content-Type = 'application/json'
    When method put
    Then status 404
    And match response.error == 'Character not found'
    And print 'Error esperado para personaje inexistente:', response
    And print 'PUT /api/characters/999 retornó 404 como se esperaba'

  Scenario: Intentar actualizar con campos faltantes/vacíos - Error 400
    * def characterId = 1
    * def updateUrl = fullUrl + '/' + characterId
    * def invalidCharacter = 
    """
    {
      "name": "",
      "alterego": "",
      "description": "",
      "powers": []
    }
    """
    Given url updateUrl
    And request invalidCharacter
    And header Content-Type = 'application/json'
    When method put
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
    And print 'Error esperado para campos vacíos:', response
    And print 'PUT /api/characters/1 retornó 400 para validación de campos'

  Scenario: Intentar actualizar con objeto vacío - Error 400
    * def characterId = 1
    * def updateUrl = fullUrl + '/' + characterId
    * def emptyCharacter = {}
    Given url updateUrl
    And request emptyCharacter
    And header Content-Type = 'application/json'
    When method put
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'
    And print 'Error esperado para objeto vacío:', response
    And print 'PUT /api/characters/1 retornó 400 para objeto sin campos'
