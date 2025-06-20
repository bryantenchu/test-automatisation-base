Feature: Marvel Characters API - Eliminar Personaje (Usuario: bronmosq)

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'bronmosq'
    * def apiPath = '/' + username + '/api/characters'
    * def fullUrl = baseUrl + apiPath

  Scenario: Eliminar personaje existente - DELETE exitoso
    # Primero creamos un personaje para eliminar
    * def timestamp = java.lang.System.currentTimeMillis()
    * def randomId = Math.floor(Math.random() * 999999)
    * def uniqueId = timestamp + '_' + randomId
    * def characterName = 'DeleteTest Hero ' + uniqueId
    * def newCharacter = 
    """
    {
      "name": "#(characterName)",
      "alterego": "Delete Test User",
      "description": "Personaje creado para ser eliminado",
      "powers": ["Temporary Power"]
    }
    """
    
    # Crear el personaje
    Given url fullUrl
    And request newCharacter
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    * def createdId = response.id
    And print 'Personaje creado para eliminar, ID:', createdId
    
    # Ahora eliminar el personaje
    * def deleteUrl = fullUrl + '/' + createdId
    Given url deleteUrl
    When method delete
    Then status 204
    And print 'Personaje eliminado exitosamente, ID:', createdId
    And print 'DELETE /api/characters/' + createdId + ' ejecutado correctamente'
    
    # Verificar que el personaje fue eliminado
    Given url deleteUrl
    When method get
    Then status 404
    And match response.error == 'Character not found'
    And print 'Verificación: personaje ya no existe'

  Scenario: Intentar eliminar personaje inexistente - Error 404
    * def nonExistentId = 999999
    * def deleteUrl = fullUrl + '/' + nonExistentId
    Given url deleteUrl
    When method delete
    Then status 404
    And match response.error == 'Character not found'
    And print 'Error esperado para personaje inexistente:', response
    And print 'DELETE /api/characters/999999 retornó 404 como se esperaba'

  Scenario: Eliminar personaje con ID inválido - Error 500
    * def invalidId = 'invalid'
    * def deleteUrl = fullUrl + '/' + invalidId
    Given url deleteUrl
    When method delete
    Then status 500
    And match response.error == 'Internal server error'
    And print 'Error esperado para ID inválido:', response
    And print 'DELETE /api/characters/invalid retornó 500 como se esperaba'
