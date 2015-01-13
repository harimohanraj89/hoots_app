
function fetchAllHoots() {
	$.get('/hoots', function(response) {
		response.forEach(renderHoot);
	});
}

function renderHoot(hootObject) {
	var hootID = hootObject.id;
	var author = hootObject.author;
	var content = hootObject.content;

	var hootDiv = $('<div>').addClass('hoot').attr('id', hootID);
	var authorDisplay = $('<p>').text(author).addClass('author');
	var contentDisplay = $('<p>').text(content).addClass('content');

	var editButton = $('<button>').addClass('edit')
																.text('Edit Hoot')
																.data('id', hootID);
	var deleteButton = $('<button>').addClass('delete')
																	.text('Delete Hoot')
																	.data('id', hootID);

	hootDiv.hide().append(authorDisplay)
								.append(contentDisplay)
								.append(editButton)
								.append(deleteButton);

	if ($('#'+ hootID).length) {
		$('#' + hootID).fadeOut(500).replaceWith(hootDiv)
	} else{
		$('#hoots').prepend(hootDiv);
	}
	hootDiv.fadeIn(500);
}

function addHoot() {
	var hootForm = $(this).parent(); // returns the div holding the form inputs
	var author = $('input[name="author"]').val(); // returns the value in the author input
	var content = $('textarea[name="content"]').val(); // returns the value in the content input
	var newHoot = {
		hoot: {
			author: author,
			content: content
		}
	}; // nested JSON object to be sent as the data of the request -> formatted to mimic nested parameters

	$.post('/hoots', newHoot) // will make a post request to '/hoots', passing the newHoot object in the body of the request
	 .done(renderHoot); // will call the renderHoot method to append the newly created tweet when a successful status code is received

	 $('input[name="author"]').val('');
	 $('textarea[name="content"]').val('');
}

function editHoot() {
	var hoot = $(this).parent();
	var hootID = $(this).data('id');

	$.get('/hoots/' + hootID)
	 .done(showEditForm);
}

function showEditForm(currentHoot) {
	var hoot = $('#'+ currentHoot.id);
	var editForm = $('<div>').addClass('hoot-form');
	var author = $('<input>').attr('name', 'edit-author');
	var content = $('<textarea>').attr('name', 'edit-content');
	var button = $('<button>').addClass('update')
														.data('id', currentHoot.id)
														.text('Update Hoot');

	author.val(currentHoot.author);
	content.val(currentHoot.content);

	editForm.hide()
					.append(author)
					.append(content)
					.append(button);
	hoot.empty()
			.append(editForm);
	editForm.fadeIn(500);
}

function updateHoot() {
	var hootID = $(this).data('id');
	var author = $('input[name="edit-author"]').val();
	var content = $('textarea[name="edit-content"]').val();
	var updatedHoot = {
		hoot: {
			author: author,
			content: content
		}
	};

	$.ajax({
		url: '/hoots/' + hootID,
		type: 'put',
		data: updatedHoot
	}).done(renderHoot);
}

function deleteHoot() {
	var hootID = $(this).data('id');
	var hoot = $(this).parent();
	$.ajax({
		url: '/hoots/' + hootID,
		type: 'delete'
	}).done(function() {
		hoot.slideUp(500, function(){ $(this).remove() });
	});
}

