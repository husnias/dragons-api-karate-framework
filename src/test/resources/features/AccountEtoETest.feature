
Feature: Account Testing

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End to End Account testing
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      { 
      "email": "#(autoEmail)",
      		"firstName": "HusniaS",
      		"lastName": "sidiqi","title": "Ms.",
      		"gender": "FEMALE","maritalStatus": "MARRIED",
      		"employmentStatus": "student",
      		"dateOfBirth": "1988-07-17"
      		} 
      """
    When method post
    Then status 201
    Then print response
    And assert response.email == autoEmail
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {
      
      "addressType": "House",
      "addressLine1": "3237 Sunrise street",
      "city": "woodbridge",
      "state": "VA",
      "postalCode": "22191",
      "countryCode": "string",
      "current": true
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.addressType == "House"
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {
      
      "phoneNumber": "202-888-9900",
      "phoneExtension": "205",
      "phoneTime": "Morning",
      "phoneType": "cell"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.phoneNumber == "202-888-9900"
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = response.id
    And request
      """
      {
      
      "make": "Audi",
      "model": "A6",
      "year": "2023",
      "licensePlate": "SUV-5577"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.make == "Audi"
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 7034
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 7034
