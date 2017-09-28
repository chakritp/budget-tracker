$(function(){
  var expenseData = gon.expense_data_set;
  var incomeData = gon.income_data_set;
  var expenseChart = Highcharts.chart('expensePieChart', {
    chart: {
      type: 'pie',
    },
    title: {
      text: 'Expenses',
      style: {
        color: '#E74C3C',
        fontWeight: 'bold'
      }
    },
    series: [{
      data: expenseData,
      innerSize: '50%'
    }]
  })

  var incomeChart = Highcharts.chart('incomePieChart', {
    chart: {
      type: 'pie',
    },
    title: {
      text: 'Income',
      style: {
        color: '#1ABB9C',
        fontWeight: 'bold'
      }
    },
    series: [{
      data: incomeData,
      innerSize: '50%'
    }]
  })
})