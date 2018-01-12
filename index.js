

var sortedRestaurants =[]; 
var alldata

function sort(){
  $.getJSON('https://raw.githubusercontent.com/chaplonglau/nyc_restaurant_week/test/rest.json', function(data){
      sortedRestaurants=[];
      alldata=data
      for (var rest in data){
        sortedRestaurants.push([data[rest].name, data[rest].rating, data[rest].review_count])
      }
      sortedRestaurants.sort(function(a,b){
        if (a[1]<b[1]){
          return 1
        }
        else if (a[1]===b[1]){
          return b[2]-a[2]
        }
        else {
          return -1
        }
      })
  }) 
}

function topRated(){
  $("#top-rated").click(function(){
      $('.restaurant').empty()
      sortedRestaurants.forEach(function(rest){
        $('.restaurant').append(`
          <div class="col-sm-6">
            <a href=${alldata[rest[0]].url}>${rest[0]}</a>
          </div>

          <div class="col-sm-3">
            <h3>${alldata[rest[0]].categories}</h3>
          </div>

          <div class="col-sm-3 text-right">
            <h3>${rest[1]} - ${rest[2]}</h3>
          </div>`
        )
      })
  })
}

function topfourfive(){
  $("#top-fourfive").click(function(){
      $('.restaurant').empty()
      sortedRestaurants.forEach(function(rest){
        if (rest[1]===4.5){
            $('.restaurant').append(`
              <div class="col-sm-6">
                <a href=${alldata[rest[0]].url}>${rest[0]}</a>
              </div>
          
              <div class="col-sm-3">
                <h3>${alldata[rest[0]].categories}</h3>
              </div>

              <div class="col-sm-3 text-right">
                <h3>${rest[1]} - ${rest[2]}</h3>
              </div>`
          )
        }    
      })
  })
}

function topfour(){
  $("#top-four").click(function(){
      $('.restaurant').empty()
      sortedRestaurants.forEach(function(rest){
        if (rest[1]===4){
            $('.restaurant').append(`
              <div class="col-sm-6">
                <a href=${alldata[rest[0]].url}>${rest[0]}</a>
              </div>

              <div class="col-sm-3">
                <h3>${alldata[rest[0]].categories}</h3>
              </div>

              <div class="col-sm-3 text-right">
                <h3>${rest[1]} - ${rest[2]}</h3>
              </div>`
            )
        }    
      })
  })
}

function topthreefive(){
  $("#top-threefive").click(function(){
      $('.restaurant').empty()
      sortedRestaurants.forEach(function(rest){
        if (rest[1]===3.5){
            $('.restaurant').append(`
              <div class="col-sm-6">
                <a href=${alldata[rest[0]].url}>${rest[0]}</a>
              </div>

              <div class="col-sm-3">
                <h3>${alldata[rest[0]].categories}</h3>
              </div>

              <div class="col-sm-3 text-right">
                <h3>${rest[1]} - ${rest[2]}</h3>
              </div>`
            )
        }    
      })
  })
}

function topthree(){
  $("#top-three").click(function(){
      $('.restaurant').empty()
      sortedRestaurants.forEach(function(rest){
        if (rest[1]<=3){
            $('.restaurant').append(`
              <div class="col-sm-6">
                <a href=${alldata[rest[0]].url}>${rest[0]}</a>
              </div>

              <div class="col-sm-3">
                <h3>${alldata[rest[0]].categories}</h3>
              </div>

              <div class="col-sm-3 text-right">
                <h3>${rest[1]} - ${rest[2]}</h3>
              </div>`
            )
        }    
      })
  })
}


$(document).ready(function(){
  sort()
  topRated()
  topfourfive()
  topfour()
  topthreefive()
  topthree()
});


