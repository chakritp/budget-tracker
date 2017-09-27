// Document ready
var $expenseButton = $('#expenseButton')
var $incomeButton = $('#incomeButton')

var $expenseRadio = $('#expenseRadio')
var $incomeRadio = $('#incomeRadio')


function initializeRadioButtons() {
  if($incomeRadio.prop('checked')){
    $incomeButton.addClass('btn-success')
  }
  else {
    $expenseButton.addClass('btn-danger')
  }
}

$(function(){
  console.log('included')
  
  initializeRadioButtons();

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

  $('input#date').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    locale: {
      format: 'DD/MM/YYYY'
    }
  })
  
  // Note: picker_1 is from the gentelella theme
  $('.daterangepicker').addClass('picker_1')
})