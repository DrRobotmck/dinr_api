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

```
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
```
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
```
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

## Actions Endpoint
The actions endpoint provides information related to the inspection action codes and their related descriptions.
#### Path
```
/api/actions
```
#### Sample request and response
```
[
  {
    id: 1,
    code: "8",
    description: "Establishment re-closed by DOHMH",
    created_at: "2014-09-24T18:23:35.746Z",
    updated_at: "2014-09-24T18:23:35.746Z"
  },
  {
    id: 2,
    code: "A",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.748Z",
    updated_at: "2014-09-24T18:23:35.748Z"
  },
  {
    id: 3,
    code: "B",
    description: "No violations were recorded at the time of this inspection.",
    created_at: "2014-09-24T18:23:35.750Z",
    updated_at: "2014-09-24T18:23:35.750Z"
  },
  {
    id: 4,
    code: "C",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.751Z",
    updated_at: "2014-09-24T18:23:35.751Z"
  },
  {
    id: 5,
    code: "D",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.752Z",
    updated_at: "2014-09-24T18:23:35.752Z"
  },
  {
    id: 6,
    code: "E",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.754Z",
    updated_at: "2014-09-24T18:23:35.754Z"
  },
  {
    id: 7,
    code: "F",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.756Z",
    updated_at: "2014-09-24T18:23:35.756Z"
  },
  {
    id: 8,
    code: "G",
    description: "Establishment Closed by DOHMH. Violations were cited in the following area(s) and those requiring immediate action were addressed.",
    created_at: "2014-09-24T18:23:35.757Z",
    updated_at: "2014-09-24T18:23:35.757Z"
  },
  {
    id: 9,
    code: "H",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.758Z",
    updated_at: "2014-09-24T18:23:35.758Z"
  },
  {
    id: 10,
    code: "I",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.760Z",
    updated_at: "2014-09-24T18:23:35.760Z"
  },
  {
    id: 11,
    code: "J",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.761Z",
    updated_at: "2014-09-24T18:23:35.761Z"
  },
  {
    id: 12,
    code: "K",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.762Z",
    updated_at: "2014-09-24T18:23:35.762Z"
  },
  {
    id: 13,
    code: "L",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.764Z",
    updated_at: "2014-09-24T18:23:35.764Z"
  },
  {
    id: 14,
    code: "M",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.765Z",
    updated_at: "2014-09-24T18:23:35.765Z"
  },
  {
    id: 15,
    code: "N",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.766Z",
    updated_at: "2014-09-24T18:23:35.766Z"
  },
  {
    id: 16,
    code: "O",
    description: "Establishment re-opened by DOHMH",
    created_at: "2014-09-24T18:23:35.768Z",
    updated_at: "2014-09-24T18:23:35.768Z"
  },
  {
    id: 17,
    code: "P",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.769Z",
    updated_at: "2014-09-24T18:23:35.769Z"
  },
  {
    id: 18,
    code: "Q",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.770Z",
    updated_at: "2014-09-24T18:23:35.770Z"
  },
  {
    id: 19,
    code: "R",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.772Z",
    updated_at: "2014-09-24T18:23:35.772Z"
  },
  {
    id: 20,
    code: "S",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.773Z",
    updated_at: "2014-09-24T18:23:35.773Z"
  },
  {
    id: 21,
    code: "T",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.775Z",
    updated_at: "2014-09-24T18:23:35.775Z"
  },
  {
    id: 22,
    code: "U",
    description: "Violations were cited in the following area(s).",
    created_at: "2014-09-24T18:23:35.776Z",
    updated_at: "2014-09-24T18:23:35.776Z"
  },
  {
    id: 23,
    code: "V",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.778Z",
    updated_at: "2014-09-24T18:23:35.778Z"
  },
  {
    id: 24,
    code: "W",
    description: "Establishment re-closed by DOHMH",
    created_at: "2014-09-24T18:23:35.779Z",
    updated_at: "2014-09-24T18:23:35.779Z"
  },
  {
    id: 25,
    code: "X",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.780Z",
    updated_at: "2014-09-24T18:23:35.780Z"
  },
  {
    id: 26,
    code: "Y",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.782Z",
    updated_at: "2014-09-24T18:23:35.782Z"
  },
  {
    id: 27,
    code: "Z",
    description: "N/A",
    created_at: "2014-09-24T18:23:35.783Z",
    updated_at: "2014-09-24T18:23:35.783Z"
  }
]
```
## Cuisines Endpoint
The cuisines endpoint provides information related to the restaurant cuisine codes and their related descriptions.
#### Path
```
/api/cuisines
```
## Violations Endpoint
The violations endpoint provides information related to all currently citable violations for restaurants in NYC. The violation code and description is provided.
#### Path
```
/api/violations
```
#### Sample response
```
[
  {
    id: 1,
    code: "01A",
    critical_violation: true,
    description: "Current valid permit, registration or other authorization to operate establishment not available. Violations points are not assessed for Smoke Free Air Act, trans fat, calorie posting or permit and poster violations.",
    created_at: "2014-09-24T18:23:35.591Z",
    updated_at: "2014-09-24T18:23:35.591Z"
  },
  {
    id: 2,
    code: "01B",
    critical_violation: true,
    description: "Document issued by the Board, Commissioner or Department unlawfully reproduced or altered.",
    created_at: "2014-09-24T18:23:35.593Z",
    updated_at: "2014-09-24T18:23:35.593Z"
  },
  {
    id: 3,
    code: "01C",
    critical_violation: true,
    description: "Notice of the department or Board mutilated, obstructed, or removed.",
    created_at: "2014-09-24T18:23:35.595Z",
    updated_at: "2014-09-24T18:23:35.595Z"
  },
  {
    id: 4,
    code: "01D",
    critical_violation: true,
    description: "Failure to comply with an Order of the Board, Commissioner or Department.",
    created_at: "2014-09-24T18:23:35.596Z",
    updated_at: "2014-09-24T18:23:35.596Z"
  },
  {
    id: 5,
    code: "01E",
    critical_violation: true,
    description: "Duties of an officer of the Department interfered with or obstructed.",
    created_at: "2014-09-24T18:23:35.598Z",
    updated_at: "2014-09-24T18:23:35.598Z"
  },
  {
    id: 6,
    code: "01F",
    critical_violation: true,
    description: "Failure to report occurrences of suspected food borne illness to the Department.",
    created_at: "2014-09-24T18:23:35.599Z",
    updated_at: "2014-09-24T18:23:35.599Z"
  },
  {
    id: 7,
    code: "02A",
    critical_violation: true,
    description: "Food not cooked to required minimum temperature.",
    created_at: "2014-09-24T18:23:35.601Z",
    updated_at: "2014-09-24T18:23:35.601Z"
  },
  {
    id: 8,
    code: "02B",
    critical_violation: true,
    description: "Hot food not held at or above 140°F.",
    created_at: "2014-09-24T18:23:35.602Z",
    updated_at: "2014-09-24T18:23:35.602Z"
  },
  {
    id: 9,
    code: "02C",
    critical_violation: true,
    description: "Hot food that has been cooked and refrigerated is being held for service without first being reheated to 165°F or above within 2 hours.",
    created_at: "2014-09-24T18:23:35.604Z",
    updated_at: "2014-09-24T18:23:35.604Z"
  },
  {
    id: 10,
    code: "02D",
    critical_violation: true,
    description: "Precooked potentially hazardous food from commercial food processing establishment that is to be heated, is not heated to 140°F within 2 hours.",
    created_at: "2014-09-24T18:23:35.606Z",
    updated_at: "2014-09-24T18:23:35.606Z"
  },
  {
    id: 11,
    code: "02E",
    critical_violation: true,
    description: "Whole frozen poultry or poultry breasts, other than a single portion, are being cooked frozen or partially thawed.",
    created_at: "2014-09-24T18:23:35.607Z",
    updated_at: "2014-09-24T18:23:35.607Z"
  },
  {
    id: 12,
    code: "02F",
    critical_violation: true,
    description: "Meat, fish or molluscan shellfish served raw or undercooked without prior notification to customer.",
    created_at: "2014-09-24T18:23:35.608Z",
    updated_at: "2014-09-24T18:23:35.608Z"
  },
  {
    id: 13,
    code: "02G",
    critical_violation: true,
    description: "Cold food held above 41°F (smoked fish above 38°F) except during necessary preparation.",
    created_at: "2014-09-24T18:23:35.610Z",
    updated_at: "2014-09-24T18:23:35.610Z"
  },
  {
    id: 14,
    code: "02H",
    critical_violation: true,
    description: "Food not cooled by an approved method whereby the internal product temperature is reduced from 140°F to 70°F or less within 2 hours and from 70°F to 45°F or less within 4 additional hours.",
    created_at: "2014-09-24T18:23:35.611Z",
    updated_at: "2014-09-24T18:23:35.611Z"
  },
  {
    id: 15,
    code: "02I",
    critical_violation: true,
    description: "Food prepared from ingredients at ambient temperature not cooled to 41°F or below within 4 hours.",
    created_at: "2014-09-24T18:23:35.612Z",
    updated_at: "2014-09-24T18:23:35.612Z"
  },
  {
    id: 16,
    code: "03A",
    critical_violation: true,
    description: "Food from unapproved or unknown source, spoiled, adulterated, or home canned.",
    created_at: "2014-09-24T18:23:35.614Z",
    updated_at: "2014-09-24T18:23:35.614Z"
  },
  {
    id: 17,
    code: "03B",
    critical_violation: true,
    description: "Shellfish not from approved source, improperly tagged/labeled; tags not retained for 90 days.",
    created_at: "2014-09-24T18:23:35.615Z",
    updated_at: "2014-09-24T18:23:35.615Z"
  },
  {
    id: 18,
    code: "03C",
    critical_violation: true,
    description: "Eggs found dirty, cracked; liquid, frozen or powdered eggs not pasteurized.",
    created_at: "2014-09-24T18:23:35.616Z",
    updated_at: "2014-09-24T18:23:35.616Z"
  },
  {
    id: 19,
    code: "03D",
    critical_violation: true,
    description: "Canned food product observed swollen, leaking, and rusted.",
    created_at: "2014-09-24T18:23:35.618Z",
    updated_at: "2014-09-24T18:23:35.618Z"
  },
  {
    id: 20,
    code: "03E",
    critical_violation: true,
    description: "Potable water system inadequate. Water or ice not potable or from unapproved source. Cross connection in potable water supply system observed.",
    created_at: "2014-09-24T18:23:35.619Z",
    updated_at: "2014-09-24T18:23:35.619Z"
  },
  {
    id: 21,
    code: "03F",
    critical_violation: true,
    description: "Unpasteurized milk or milk product present.",
    created_at: "2014-09-24T18:23:35.620Z",
    updated_at: "2014-09-24T18:23:35.620Z"
  },
  {
    id: 22,
    code: "03G",
    critical_violation: true,
    description: "Raw food not properly washed prior to serving.",
    created_at: "2014-09-24T18:23:35.622Z",
    updated_at: "2014-09-24T18:23:35.622Z"
  },
  {
    id: 23,
    code: "04A",
    critical_violation: true,
    description: "Food Protection Certificate not held by supervisor of food operations.",
    created_at: "2014-09-24T18:23:35.623Z",
    updated_at: "2014-09-24T18:23:35.623Z"
  },
  {
    id: 24,
    code: "04B",
    critical_violation: true,
    description: "Food worker prepares food or handles utensil when ill with a disease transmissible by food, or have exposed infected cut or burn on their hand.",
    created_at: "2014-09-24T18:23:35.624Z",
    updated_at: "2014-09-24T18:23:35.624Z"
  },
  {
    id: 25,
    code: "04C",
    critical_violation: true,
    description: "Food worker does not use proper utensil to eliminate bare hand contact with food that will not receive adequate additional heat treatment.",
    created_at: "2014-09-24T18:23:35.626Z",
    updated_at: "2014-09-24T18:23:35.626Z"
  },
  {
    id: 26,
    code: "04D",
    critical_violation: true,
    description: "Food worker does not wash hands thoroughly after visiting the toilet, coughing, sneezing, smoking, preparing raw foods or otherwise contaminating hands.",
    created_at: "2014-09-24T18:23:35.627Z",
    updated_at: "2014-09-24T18:23:35.627Z"
  },
  {
    id: 27,
    code: "04E",
    critical_violation: true,
    description: "Toxic chemical improperly labeled, stored or used so that contamination of food may occur.",
    created_at: "2014-09-24T18:23:35.629Z",
    updated_at: "2014-09-24T18:23:35.629Z"
  },
  {
    id: 28,
    code: "04F",
    critical_violation: true,
    description: "Food, food preparation area, food storage area, area used by employees or patrons, contaminated by sewage or liquid waste.",
    created_at: "2014-09-24T18:23:35.630Z",
    updated_at: "2014-09-24T18:23:35.630Z"
  },
  {
    id: 29,
    code: "04G",
    critical_violation: true,
    description: "Unprotected potentially hazardous food re-served.",
    created_at: "2014-09-24T18:23:35.631Z",
    updated_at: "2014-09-24T18:23:35.631Z"
  },
  {
    id: 30,
    code: "04H",
    critical_violation: true,
    description: "Food in contact with utensil, container, or pipe that consist of toxic material.",
    created_at: "2014-09-24T18:23:35.633Z",
    updated_at: "2014-09-24T18:23:35.633Z"
  },
  {
    id: 31,
    code: "04I",
    critical_violation: true,
    description: "Food item spoiled, adulterated, contaminated or cross-contaminated.",
    created_at: "2014-09-24T18:23:35.634Z",
    updated_at: "2014-09-24T18:23:35.634Z"
  },
  {
    id: 32,
    code: "04J",
    critical_violation: true,
    description: "Unprotected food re-served.",
    created_at: "2014-09-24T18:23:35.635Z",
    updated_at: "2014-09-24T18:23:35.635Z"
  },
  {
    id: 33,
    code: "04K",
    critical_violation: true,
    description: "Appropriately scaled metal stem-type thermometer not provided or used to evaluate temperatures of potentially hazardous foods during cooking, cooling, reheating and holding.",
    created_at: "2014-09-24T18:23:35.637Z",
    updated_at: "2014-09-24T18:23:35.637Z"
  },
  {
    id: 34,
    code: "04L",
    critical_violation: true,
    description: "Evidence of rats or live rats present in facility's food and/or non-food areas.",
    created_at: "2014-09-24T18:23:35.638Z",
    updated_at: "2014-09-24T18:23:35.638Z"
  },
  {
    id: 35,
    code: "04M",
    critical_violation: true,
    description: "Evidence of mice or live mice present in facility's food and/or non-food areas.",
    created_at: "2014-09-24T18:23:35.639Z",
    updated_at: "2014-09-24T18:23:35.639Z"
  },
  {
    id: 36,
    code: "04N",
    critical_violation: true,
    description: "Evidence of roaches or live roaches present in facility's food and/or non-food areas.",
    created_at: "2014-09-24T18:23:35.640Z",
    updated_at: "2014-09-24T18:23:35.640Z"
  },
  {
    id: 37,
    code: "04O",
    critical_violation: true,
    description: "Evidence of flying insects or live flying insects present in facility's food and/or non-food areas.",
    created_at: "2014-09-24T18:23:35.642Z",
    updated_at: "2014-09-24T18:23:35.642Z"
  },
  {
    id: 38,
    code: "04P",
    critical_violation: true,
    description: "Other live animal present in facility's food and/or non-food areas.",
    created_at: "2014-09-24T18:23:35.643Z",
    updated_at: "2014-09-24T18:23:35.643Z"
  },
  {
    id: 39,
    code: "05A",
    critical_violation: true,
    description: "Sewage disposal system improper or unapproved.",
    created_at: "2014-09-24T18:23:35.644Z",
    updated_at: "2014-09-24T18:23:35.644Z"
  },
  {
    id: 40,
    code: "05B",
    critical_violation: true,
    description: "Harmful, noxious gas or vapor detected. CO > 13 ppm.",
    created_at: "2014-09-24T18:23:35.646Z",
    updated_at: "2014-09-24T18:23:35.646Z"
  },
  {
    id: 41,
    code: "05C",
    critical_violation: true,
    description: "Food contact surface improperly constructed or located. Unacceptable material used.",
    created_at: "2014-09-24T18:23:35.647Z",
    updated_at: "2014-09-24T18:23:35.647Z"
  },
  {
    id: 42,
    code: "05D",
    critical_violation: true,
    description: "Hand washing facility not provided in or near food preparation area and toilet room. Hot and cold running water at adequate pressure not provided at facility. Soap and an acceptable hand-drying device not provided.",
    created_at: "2014-09-24T18:23:35.648Z",
    updated_at: "2014-09-24T18:23:35.648Z"
  },
  {
    id: 43,
    code: "05E",
    critical_violation: true,
    description: "Toilet facility not provided for employees or for patrons when required.",
    created_at: "2014-09-24T18:23:35.650Z",
    updated_at: "2014-09-24T18:23:35.650Z"
  },
  {
    id: 44,
    code: "05F",
    critical_violation: true,
    description: "Refrigerated or hot holding equipment to keep potentially hazardous foods at required temperatures not provided.",
    created_at: "2014-09-24T18:23:35.651Z",
    updated_at: "2014-09-24T18:23:35.651Z"
  },
  {
    id: 45,
    code: "05G",
    critical_violation: true,
    description: "Sufficient refrigerated or hot holding equipment not provided to meet proper time and temperature requirements for potentially hazardous foods.",
    created_at: "2014-09-24T18:23:35.652Z",
    updated_at: "2014-09-24T18:23:35.652Z"
  },
  {
    id: 46,
    code: "05H",
    critical_violation: true,
    description: "Properly enclosed service/maintenance area not provided.",
    created_at: "2014-09-24T18:23:35.654Z",
    updated_at: "2014-09-24T18:23:35.654Z"
  },
  {
    id: 47,
    code: "05I",
    critical_violation: true,
    description: "No facility available to wash, rinse, and sanitize utensils and/or equipment not provided.",
    created_at: "2014-09-24T18:23:35.656Z",
    updated_at: "2014-09-24T18:23:35.656Z"
  },
  {
    id: 48,
    code: "05J",
    critical_violation: true,
    description: "Nuisance created or allowed to exist. Facility not free from unsafe, hazardous, offensive or annoying condition.",
    created_at: "2014-09-24T18:23:35.658Z",
    updated_at: "2014-09-24T18:23:35.658Z"
  },
  {
    id: 49,
    code: "06A",
    critical_violation: true,
    description: "Personal cleanliness inadequate. Clean outer garments, effective hair restraint not worn.",
    created_at: "2014-09-24T18:23:35.659Z",
    updated_at: "2014-09-24T18:23:35.659Z"
  },
  {
    id: 50,
    code: "06B",
    critical_violation: true,
    description: "Tobacco use, eating, drinking in food preparation, food storage or dishwashing area observed.",
    created_at: "2014-09-24T18:23:35.661Z",
    updated_at: "2014-09-24T18:23:35.661Z"
  },
  {
    id: 51,
    code: "06C",
    critical_violation: true,
    description: "Food not protected from potential source of contamination during storage, preparation, transportation, display or service.",
    created_at: "2014-09-24T18:23:35.662Z",
    updated_at: "2014-09-24T18:23:35.662Z"
  },
  {
    id: 52,
    code: "06D",
    critical_violation: true,
    description: "Food contact surface not properly washed, rinsed and sanitized after each use and following any activity when contamination may have occurred.",
    created_at: "2014-09-24T18:23:35.663Z",
    updated_at: "2014-09-24T18:23:35.663Z"
  },
  {
    id: 53,
    code: "06E",
    critical_violation: true,
    description: "Sanitized equipment or utensil, including in-use food dispensing utensil, improperly used or stored.",
    created_at: "2014-09-24T18:23:35.665Z",
    updated_at: "2014-09-24T18:23:35.665Z"
  },
  {
    id: 54,
    code: "06F",
    critical_violation: true,
    description: "Wiping cloths dirty or not stored in sanitizing solution.",
    created_at: "2014-09-24T18:23:35.666Z",
    updated_at: "2014-09-24T18:23:35.666Z"
  },
  {
    id: 55,
    code: "07A",
    critical_violation: true,
    description: "Administration other",
    created_at: "2014-09-24T18:23:35.667Z",
    updated_at: "2014-09-24T18:23:35.667Z"
  },
  {
    id: 56,
    code: "07B",
    critical_violation: true,
    description: "Food Temperature",
    created_at: "2014-09-24T18:23:35.669Z",
    updated_at: "2014-09-24T18:23:35.669Z"
  },
  {
    id: 57,
    code: "07C",
    critical_violation: true,
    description: "Food Source",
    created_at: "2014-09-24T18:23:35.670Z",
    updated_at: "2014-09-24T18:23:35.670Z"
  },
  {
    id: 58,
    code: "07D",
    critical_violation: true,
    description: "Food Protection",
    created_at: "2014-09-24T18:23:35.671Z",
    updated_at: "2014-09-24T18:23:35.671Z"
  },
  {
    id: 59,
    code: "07E",
    critical_violation: true,
    description: "Facility Design",
    created_at: "2014-09-24T18:23:35.672Z",
    updated_at: "2014-09-24T18:23:35.672Z"
  },
  {
    id: 60,
    code: "07F",
    critical_violation: true,
    description: "Personal Hygiene and other food protection",
    created_at: "2014-09-24T18:23:35.674Z",
    updated_at: "2014-09-24T18:23:35.674Z"
  },
  {
    id: 61,
    code: "08A",
    critical_violation: false,
    description: "Facility not vermin proof. Harborage or conditions conducive to vermin exist.",
    created_at: "2014-09-24T18:23:35.675Z",
    updated_at: "2014-09-24T18:23:35.675Z"
  },
  {
    id: 62,
    code: "08B",
    critical_violation: false,
    description: "Garbage receptacles not provided or inadequate. Garbage storage area not properly constructed or maintained; grinder or compactor dirty.",
    created_at: "2014-09-24T18:23:35.677Z",
    updated_at: "2014-09-24T18:23:35.677Z"
  },
  {
    id: 63,
    code: "08C",
    critical_violation: false,
    description: "Pesticide use not in accordance with label or applicable laws. Prohibited chemical used/stored. Open bait station used.",
    created_at: "2014-09-24T18:23:35.678Z",
    updated_at: "2014-09-24T18:23:35.678Z"
  },
  {
    id: 64,
    code: "09A",
    critical_violation: false,
    description: "Canned food product observed severely dented.",
    created_at: "2014-09-24T18:23:35.679Z",
    updated_at: "2014-09-24T18:23:35.679Z"
  },
  {
    id: 65,
    code: "09B",
    critical_violation: false,
    description: "Milk or milk product undated, improperly dated or expired.",
    created_at: "2014-09-24T18:23:35.681Z",
    updated_at: "2014-09-24T18:23:35.681Z"
  },
  {
    id: 66,
    code: "09C",
    critical_violation: false,
    description: "Thawing procedures improper.",
    created_at: "2014-09-24T18:23:35.682Z",
    updated_at: "2014-09-24T18:23:35.682Z"
  },
  {
    id: 67,
    code: "09D",
    critical_violation: false,
    description: "Food contact surface not properly maintained.",
    created_at: "2014-09-24T18:23:35.684Z",
    updated_at: "2014-09-24T18:23:35.684Z"
  },
  {
    id: 68,
    code: "10A",
    critical_violation: false,
    description: "Toilet facility not maintained and provided with toilet paper, waste receptacle and self-closing door.",
    created_at: "2014-09-24T18:23:35.685Z",
    updated_at: "2014-09-24T18:23:35.685Z"
  },
  {
    id: 69,
    code: "10B",
    critical_violation: false,
    description: "Plumbing not properly installed or maintained; anti-siphonage or backflow prevention device not provided where required; equipment or floor not properly drained; sewage disposal system in disrepair or not functioning properly.",
    created_at: "2014-09-24T18:23:35.687Z",
    updated_at: "2014-09-24T18:23:35.687Z"
  },
  {
    id: 70,
    code: "10C",
    critical_violation: false,
    description: "Lighting inadequate. Bulb not shielded or shatterproof.",
    created_at: "2014-09-24T18:23:35.688Z",
    updated_at: "2014-09-24T18:23:35.688Z"
  },
  {
    id: 71,
    code: "10D",
    critical_violation: false,
    description: "Ventilation system not provided, improperly installed or in disrepair.",
    created_at: "2014-09-24T18:23:35.689Z",
    updated_at: "2014-09-24T18:23:35.689Z"
  },
  {
    id: 72,
    code: "10E",
    critical_violation: false,
    description: "Accurate thermometer not provided in refrigerated or hot holding equipment.",
    created_at: "2014-09-24T18:23:35.691Z",
    updated_at: "2014-09-24T18:23:35.691Z"
  },
  {
    id: 73,
    code: "10F",
    critical_violation: false,
    description: "Equipment not easily movable or sealed to floor, adjoining equipment, adjacent walls or ceiling. Aisle or workspace inadequate.",
    created_at: "2014-09-24T18:23:35.692Z",
    updated_at: "2014-09-24T18:23:35.692Z"
  },
  {
    id: 74,
    code: "10G",
    critical_violation: false,
    description: "Non-food contact surface improperly constructed. Unacceptable material used. Non-food contact surface or equipment improperly maintained.",
    created_at: "2014-09-24T18:23:35.693Z",
    updated_at: "2014-09-24T18:23:35.693Z"
  },
  {
    id: 75,
    code: "10H",
    critical_violation: false,
    description: "Food service operation occurring in room used as living or sleeping quarters.",
    created_at: "2014-09-24T18:23:35.694Z",
    updated_at: "2014-09-24T18:23:35.694Z"
  },
  {
    id: 76,
    code: "10I",
    critical_violation: false,
    description: "Minimum final rinse temperature of 170°F or proper chemical and temperature levels not maintained in manual utensil washing operation.",
    created_at: "2014-09-24T18:23:35.696Z",
    updated_at: "2014-09-24T18:23:35.696Z"
  },
  {
    id: 77,
    code: "10J",
    critical_violation: false,
    description: "Mechanical dishwasher not operated as per manufacturer's specifications (time/temperature/chemical concentration); machine defective.",
    created_at: "2014-09-24T18:23:35.697Z",
    updated_at: "2014-09-24T18:23:35.697Z"
  },
  {
    id: 78,
    code: "10K",
    critical_violation: false,
    description: "Immersion basket not provided, used or of incorrect size. Incorrect manual technique. Test kit and thermometer not provided or used. Improper drying practices.",
    created_at: "2014-09-24T18:23:35.699Z",
    updated_at: "2014-09-24T18:23:35.699Z"
  },
  {
    id: 79,
    code: "10L",
    critical_violation: false,
    description: "Single service item reused, improperly stored, dispensed; not used when required.",
    created_at: "2014-09-24T18:23:35.700Z",
    updated_at: "2014-09-24T18:23:35.700Z"
  },
  {
    id: 80,
    code: "11A",
    critical_violation: false,
    description: "Permit not conspicuously displayed.",
    created_at: "2014-09-24T18:23:35.702Z",
    updated_at: "2014-09-24T18:23:35.702Z"
  },
  {
    id: 81,
    code: "11B",
    critical_violation: false,
    description: "Manufacture of frozen dessert not authorized on Food Service Establishment permit.",
    created_at: "2014-09-24T18:23:35.703Z",
    updated_at: "2014-09-24T18:23:35.703Z"
  },
  {
    id: 82,
    code: "11C",
    critical_violation: false,
    description: "Failure of event sponsor to exclude vendor without a current valid permit or registration.",
    created_at: "2014-09-24T18:23:35.704Z",
    updated_at: "2014-09-24T18:23:35.704Z"
  },
  {
    id: 83,
    code: "11D",
    critical_violation: false,
    description: ""Choking first aid" poster not posted."Alcohol and Pregnancy" Warning sign not posted. "Wash hands" sign not posted at hand wash facility. Resuscitation equipment: exhaled air resuscitation masks(adult & pediatric), latex gloves, sign not posted. Inspection report sign not posted.",
    created_at: "2014-09-24T18:23:35.706Z",
    updated_at: "2014-09-24T18:23:35.706Z"
  },
  {
    id: 84,
    code: "12A",
    critical_violation: false,
    description: "Other general violation.",
    created_at: "2014-09-24T18:23:35.707Z",
    updated_at: "2014-09-24T18:23:35.707Z"
  },
  {
    id: 85,
    code: "15A",
    critical_violation: false,
    description: "Tobacco vending machine present where prohibited.",
    created_at: "2014-09-24T18:23:35.709Z",
    updated_at: "2014-09-24T18:23:35.709Z"
  },
  {
    id: 86,
    code: "15B",
    critical_violation: false,
    description: "Tobacco vending machine place less than 25' from entrance to premises.",
    created_at: "2014-09-24T18:23:35.710Z",
    updated_at: "2014-09-24T18:23:35.710Z"
  },
  {
    id: 87,
    code: "15C",
    critical_violation: false,
    description: "Tobacco vending machine not visible to the operator, employee or agent.",
    created_at: "2014-09-24T18:23:35.712Z",
    updated_at: "2014-09-24T18:23:35.712Z"
  },
  {
    id: 88,
    code: "15D",
    critical_violation: false,
    description: "Durable sign with license number, expiration date, and address and phone number not posted.",
    created_at: "2014-09-24T18:23:35.713Z",
    updated_at: "2014-09-24T18:23:35.713Z"
  },
  {
    id: 89,
    code: "15E",
    critical_violation: false,
    description: "Out-of package sale observed.",
    created_at: "2014-09-24T18:23:35.715Z",
    updated_at: "2014-09-24T18:23:35.715Z"
  },
  {
    id: 90,
    code: "15F",
    critical_violation: false,
    description: "Age restriction on handling not enforced.",
    created_at: "2014-09-24T18:23:35.717Z",
    updated_at: "2014-09-24T18:23:35.717Z"
  },
  {
    id: 91,
    code: "15G",
    critical_violation: false,
    description: "Sale to minor observed.",
    created_at: "2014-09-24T18:23:35.718Z",
    updated_at: "2014-09-24T18:23:35.718Z"
  },
  {
    id: 92,
    code: "15H",
    critical_violation: false,
    description: "Sign prohibiting sale of tobacco products to minors not conspicuously posted.",
    created_at: "2014-09-24T18:23:35.719Z",
    updated_at: "2014-09-24T18:23:35.719Z"
  },
  {
    id: 93,
    code: "15I",
    critical_violation: false,
    description: ""Smoking Permitted" and/or "No Smoking" sign not conspicuously posted. Health warning not present on "Smoking Permitted" sign.",
    created_at: "2014-09-24T18:23:35.721Z",
    updated_at: "2014-09-24T18:23:35.721Z"
  },
  {
    id: 94,
    code: "15J",
    critical_violation: false,
    description: "Ashtray present in smoke-free area.",
    created_at: "2014-09-24T18:23:35.722Z",
    updated_at: "2014-09-24T18:23:35.722Z"
  },
  {
    id: 95,
    code: "15K",
    critical_violation: false,
    description: "Failure to make good faith effort to inform violator. Violations points are not assessed for Smoke Free Air Act, trans fat, calorie posting or permit and poster violations.",
    created_at: "2014-09-24T18:23:35.724Z",
    updated_at: "2014-09-24T18:23:35.724Z"
  },
  {
    id: 96,
    code: "15L",
    critical_violation: false,
    description: "Work place smoking policy inadequate, not posted, not provided.",
    created_at: "2014-09-24T18:23:35.725Z",
    updated_at: "2014-09-24T18:23:35.725Z"
  },
  {
    id: 97,
    code: "15M",
    critical_violation: false,
    description: "Use of tobacco product on school premises (at or below the 12th grade level) observed.",
    created_at: "2014-09-24T18:23:35.726Z",
    updated_at: "2014-09-24T18:23:35.726Z"
  },
  {
    id: 98,
    code: "15N",
    critical_violation: false,
    description: "Other/Employee in separate smoking room.",
    created_at: "2014-09-24T18:23:35.728Z",
    updated_at: "2014-09-24T18:23:35.728Z"
  },
  {
    id: 99,
    code: "15O",
    critical_violation: false,
    description: "Sale of herbal cigarettes to minors observed.",
    created_at: "2014-09-24T18:23:35.729Z",
    updated_at: "2014-09-24T18:23:35.729Z"
  },
  {
    id: 100,
    code: "16A",
    critical_violation: false,
    description: "A food containing 0.5 grams or more of artificial trans fat per serving, is being served, stored, distributed, held for service, or used in preparation of a menu item.",
    created_at: "2014-09-24T18:23:35.730Z",
    updated_at: "2014-09-24T18:23:35.730Z"
  },
  {
    id: 101,
    code: "16B",
    critical_violation: false,
    description: "The original nutritional fact labels and/or ingredient label for, or acceptable manufacturer's documentation for a product containing oil, shortening or margarine is not maintained on site.",
    created_at: "2014-09-24T18:23:35.732Z",
    updated_at: "2014-09-24T18:23:35.732Z"
  },
  {
    id: 102,
    code: "16C",
    critical_violation: false,
    description: "Caloric content not posted on menus, menu boards or food tags.",
    created_at: "2014-09-24T18:23:35.733Z",
    updated_at: "2014-09-24T18:23:35.733Z"
  },
  {
    id: 103,
    code: "16D",
    critical_violation: false,
    description: "Posted caloric content on the menu(s), menu board(s), food tag(s) or stanchions",
    created_at: "2014-09-24T18:23:35.734Z",
    updated_at: "2014-09-24T18:23:35.734Z"
  },
  {
    id: 104,
    code: "16E",
    critical_violation: false,
    description: "Caloric content range (minimum to maximum) not posted on menus and or menu",
    created_at: "2014-09-24T18:23:35.735Z",
    updated_at: "2014-09-24T18:23:35.735Z"
  },
  {
    id: 105,
    code: "16F",
    critical_violation: false,
    description: "Specific caloric content or range thereof not posted on menus, menu boards or",
    created_at: "2014-09-24T18:23:35.737Z",
    updated_at: "2014-09-24T18:23:35.737Z"
  }
]
```
