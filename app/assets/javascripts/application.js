// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require cocoon
function ajax(type, url, postData, callback){
 $.ajax({
   url: url,
   type: type,
   data: postData,
  success: callback
 });
}

function checkNotNull(value){
  if(value){
    return true;
  }
  return false;
}

function validate(value){
  if(checkNotNull(value)){
    if(parseInt(value) >= 0){
      return true;
    }
  }
  return false;
}


function updateQty(qty, amt){
  if(qty){
    qty.text(parseInt(qty.text()) + parseInt(amt));
    updatePrice();
  }
}

function showInCart(response){
  var myCart = $('.myCart');
  var items = $('.myCart > .items');
  var names = $('.myCart > .items .name');
  var toAppend = true;
  names.each(function(){
    if($(this).text() == response.name){
      updateQty($(this).siblings('.qty'), response.qty);
      toAppend = false;
    }
  });
  if(toAppend){
    items.append("<div class='well'><button class='remove btn btn-danger'>X</button></br><h3 class='name'>"+response.name+"</h3><h3>Quantity : </h3><h3 class='qty'>"+response.qty+"</h3><h3>Price : </h3><h3 class='price'>"+response.price+"</h3><button class='add btn btn-primary'> + </button>&nbsp<button class='subtract btn btn-danger'> - </button></div>");
    updatePrice();
  }
}

function updatePrice(){
  var total = 0;
  $('.myCart > .items > .well').each(function(){
    var qty = parseInt($(this).children('.qty').text());
    var cost = parseInt($(this).children('.price').text());
    total += qty*cost;
  });
  $('.myCart > .total').html("Total : "+total);
}


function sendData(){
  var postData = {};
  postData.items = [];
  var i = 0;
  $('.myCart > .items > .well').each(function(){
    postData.items[i] = {};
    postData.items[i].name = $(this).children('.name').text();
    postData.items[i].qty = parseInt($(this).children('.qty').text());
    postData.items[i].cost = parseInt($(this).children('.price').text());
    i+=1;
  });
    ajax('post', '/', postData, function(response){
        if(response){
          window.location = "/confirmation";
        }
    });

}


function addItem(quantity, name, price, remove, append){
  ajax('post', '/', {"quantity":quantity, "ItemName":name, "price":price, "remove": false}, function(response){
    if(append){
      showInCart(response);
    }else{

    }
  });
}


function removeItem(quantity, name, price, remove){
  ajax('post', '/', {"quantity":quantity, "ItemName":name, "price":price, "remove": true}, function(response){
    showInCart(response);
  });
}

$(document).ready(function(){
  var addToCart = $('.cart');

  addToCart.on("click", function(e){
    var getFood = $('#getFood');
    var quantity = $(this).siblings().children().val();
    var name = $(this).parents('.caption').children('.name').text();
    var price = $(this).parents(".caption").children(".price").text();
    addItem(quantity, name, price, false, true);
  });

  $('.myCart > .items').on('click', '.subtract', function(){
    var qty = $(this).siblings('.qty');
    if(qty && (parseInt(qty.text()) > 1)){
      updateQty(qty, -1);
    }else{
    }
  });

  $('.myCart > .items').on('click', '.add', function(){
    var qty = $(this).siblings('.qty');
    updateQty(qty, 1);
  });

  $('.myCart > .items').on('click', '.remove', function(){
    $(this).parent().remove();
    updatePrice();
  });
  $('.getFood').on('click', function(){
      sendData();
  });

  var mail = $('.mail');

  mail.on("click", function(e){

    var name = $(".na").val();
    console.log(name)
    var address = $(".ad").val();
    var email =  $(".em").val();
    var phone =  $(".ph").val();

    ajax('post', '/confirmation', {"name":name, "add":address, "email":email, "phone": phone} , function(){
        $(".confirmation-container").html("<div class='form-group'><h3>Order sent, we will contact you soon</h3></div> ")

    } );



  });

});
