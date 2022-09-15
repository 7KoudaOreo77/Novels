window.addEventListener('DOMContentLoaded', function(){

  // input要素を取得
  var input_name = document.getElementById("[page]");

  // イベントリスナーでイベント「change」を登録
  input_name.addEventListener("change",function(){
    console.log("Change action");
    console.log(this.value);
  });

  // イベントリスナーでイベント「input」を登録
  input_name.addEventListener("input",function(){
    console.log("Input action");
    console.log(this.value);
  });
});

