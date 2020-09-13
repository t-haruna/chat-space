$(function(){
  function buildHTML(message){
    if (message.image) {
      let html = `<div class ="group-contents" data-message-id=${message.id}>
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
      let html = `<div class ="group-contents" data-message-id=${message.id}>
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

  

  let reloadMessages = function() {
    let last_message_id  = $('.group-contents:last').data("message-id") || 0;
    $.ajax({
      url: "api/messages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {  
      if (messages.length !== 0) {
        let insertHTML = '';
        $.each(messages, function(i, message) {
          insertHTML += buildHTML(message)
        });
        $('.Main__message-list').append(insertHTML);
        $('.Main__message-list').animate({ scrollTop: $('.Main__message-list')[0].scrollHeight});
    }
  })
    .fail(function() {
      alert('error');
    });
  };
  setInterval(reloadMessages, 7000);
});
