Feature: Crear usuario de ayuda

  Background:
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataGenerator = read('classpath:utils/random-user-data-generator.js')
    * url baseUrl
    * header Authorization = getBearerToken()

  Scenario: Usuario creado exitosamente
    * def email = randomDataGenerator().generateRandomEmail()
    * def name = randomDataGenerator().generateRandomName()
    * def gender = randomDataGenerator().generateRandomGender()
    * def status = randomDataGenerator().generateRandomStatus()

    * def newUser =
      """
      {
        "name": "#(name)",
        "gender": "#(gender)",
        "email": "#(email)",
        "status": "#(status)"
      }
      """

    Given path 'users'
    And request newUser
    When method post
    Then status 201