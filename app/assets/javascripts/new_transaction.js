// Document ready
var $expenseButton = $('#expenseButton')
var $incomeButton = $('#incomeButton')

var $expenseRadio = $('#expenseRadio')
var $incomeRadio = $('#incomeRadio')


$(function(){
  console.log('included')
  // console.log(moment())
  // $('input#date').daterangepicker()
  $expenseButton.on('click', function(){
    $incomeButton.removeClass('btn-success').addClass('btn-default')
    $incomeRadio.prop('checked', false)
    $expenseRadio.prop('checked', true)
    $(this).removeClass('btn-default')
    $(this).addClass('btn-danger')
  })

  $incomeButton.on('click', function(){
    $expenseButton.removeClass('btn-danger').addClass('btn-default')
    $expenseRadio.prop('checked', false)
    $incomeRadio.prop('checked', true)
    $(this).removeClass('btn-default')
    $(this).addClass('btn-success')
  })

})