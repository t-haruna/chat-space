$(function(){
  function buildHTML(message){
    if (message.image) {
      let html = `<div class ="group-contents">
                    <div class ="group-contents__box">
                      <div class ="group-contents__box--name">
                        ${message.user_name}
                      </div>
                      <div class ="group-contents__box--times">
                        ${message.created_at}
                      </div>
                    </div>
                    <div class ="group-contents__comment">
                      <p class ="Message__content">
                        ${message.content}
                      </p>
                      <img class="Message__image" src="${message.image}">
                    </div>
                  </div>`
                 return html;
    } else {
      let html = `<div class ="group-contents">
                    <div class ="group-contents__box">
                      <div class ="group-contents__box--name">
                        ${message.user_name}
                      </div>
                      <div class ="group-contents__box--times">
                        ${message.created_at}
                      </div>
                    </div>
                    <div class ="group-contents__comment">
                      <p class ="Message__content">
                        ${message.content}
                      </div>
                    </div>
                  </div>`
                 return html;
    };
  }

  $('.Form').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(message){
      let html = buildHTML(message)
     $('.Main__message-list').append(html)
     $('.Main__message-list').animate({ scrollTop: $('.Main__message-list')[0].scrollHeight});
     $('form')[0].reset();
     $(".message-form__btn--send").removeAttr("disabled");
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
  });
    
  });
});