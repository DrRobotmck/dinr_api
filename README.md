# Dinr API Documentation

Dinr provides a web API for NYC food service establishment health inspection results.

## Access to the API

The Dinr API is open. No key or authentication is required to gain access to the API. The API was implemented using a REST-like interface and is also CORS friendly.
The API provides JSON and XML endpoints for accessing the restaurant information.
### API Base URL

```
dinr-api.mckenneth.com
```

### Endpoints
- restaurants
- camis
- actions
- violations
- cuisines

## Restaurants Endpoint
#### Path
```
/api/restaurants
```
The restaurants endpoint provides access to the basic information for a restaurant. It does not include information related to the inspection results or violation history for the restaurants returned.

#### Params
- dba - name of the restaurant
- cuisine - limit the search by cuisine type
- boro - limit the search to a particular boro
- current_grade - limit the search by current grade
- zip_code - limit the search by zip code

You can provide as many parameters or as few as you would like. All punctuation should be escaped and capitalization is not important. Multiple words should be separated using a `+`.

#### Sample Request and Response
```
http://dinr-api.mckenneth.com/api/restaurants?dba=mcdonald&zip_code=11222
```

```json
{
  response: {
    data: [
      {
        id: 2575,
        camis: 40686067,
        dba: "MCDONALD'S",
        building_number: "652",
        street_address: "MEEKER AVE",
        zip_code: 11222,
        phone_number: "7184866195",
        current_grade: "A",
        boro_code: 3,
        boro_name: "Brooklyn",
        cuisine_code: "39",
        cuisine_type: "Hamburgers",
        total_inspections: 3,
        last_updated: "2014-09-27T19:32:31.389Z"
      },
      {
        id: 6905,
        camis: 41238965,
        dba: "MCDONALD'S",
        building_number: "904",
        street_address: "MANHATTAN AVENUE",
        zip_code: 11222,
        phone_number: "7183890851",
        current_grade: "A",
        boro_code: 3,
        boro_name: "Brooklyn",
        cuisine_code: "39",
        cuisine_type: "Hamburgers",
        total_inspections: 0,
        last_updated: "2014-09-27T19:47:24.912Z"
      }
    ],
    query_params: {
      dba: "mcdonald",
      zip_code: "11222",
      format: "json",
      action: "index",
      controller: "api/restaurants"
    }
  }
}
```

### Search By ID (no parameters)
Returns the information for a single restaurant and all attributed inspection and violations.
```
http://dinr-api.com/api/restaurants/2575
```

#### Sample response
```json
{
  data: {
    restaurant: {
      id: 2575,
      camis: 40686067,
      dba: "MCDONALD'S",
      building_number: "652",
      street_address: "MEEKER AVE",
      zip_code: 11222,
      phone_number: "7184866195",
      current_grade: "A",
      boro_code: 3,
      boro_name: "Brooklyn",
      cuisine_code: "39",
      cuisine_type: "Hamburgers",
      total_inspections: 3,
      inspections: [
        {
          date_inspected: "2013-04-22",
          score: 2,
          action_code: "D",
          action_details: "Violations were cited in the following area(s).",
          violations: [
            {
              code: "10F",
              description: "Equipment not easily movable or sealed to floor, adjoining equipment, adjacent walls or ceiling. Aisle or workspace inadequate.",
              critical_violation: false
            }
          ]
        },
        {
          date_inspected: "2013-11-30",
          score: null,
          action_code: "B",
          action_details: "No violations were recorded at the time of this inspection.",
          violations: [ ]
        },
        {
          date_inspected: "2012-08-23",
          score: null,
          action_code: "B",
          action_details: "No violations were recorded at the time of this inspection.",
          violations: [ ]
        }
      ],
      last_updated: "2014-09-27T19:32:31.389Z"
    }
  }
}
```

## CAMIS Endpoint
#### Path
```
/api/camis
```
The CAMIS endpoint provides access to detailed information about a particular restaurant. It includes the inspection history and the violation history for each inspection. It also provides information about what a particular violation means.

#### Sample request and response
Request
```
http://dinr-api.mckenneth.com/api/camis/40686067
```
Response
```json
{
  data: {
    restaurant: {
      id: 2575,
      camis: 40686067,
      dba: "MCDONALD'S",
      building_number: "652",
      street_address: "MEEKER AVE",
      zip_code: 11222,
      phone_number: "7184866195",
      current_grade: "A",
      boro_code: 3,
      boro_name: "Brooklyn",
      cuisine_code: "39",
      cuisine_type: "Hamburgers",
      total_inspections: 3,
      inspections: [
        {
          date_inspected: "2013-04-22",
          score: 2,
          action_code: "D",
          action_details: "Violations were cited in the following area(s).",
          violations: [
            {
              code: "10F",
              description: "Equipment not easily movable or sealed to floor, adjoining equipment, adjacent walls or ceiling. Aisle or workspace inadequate.",
              critical_violation: false
            }
          ]
        },
        {
          date_inspected: "2013-11-30",
          score: null,
          action_code: "B",
          action_details: "No violations were recorded at the time of this inspection.",
          violations: [ ]
        },
        {
          date_inspected: "2012-08-23",
          score: null,
          action_code: "B",
          action_details: "No violations were recorded at the time of this inspection.",
          violations: [ ]
        }
      ],
      last_updated: "2014-09-27T19:32:31.389Z"
    }
  }
}
```
