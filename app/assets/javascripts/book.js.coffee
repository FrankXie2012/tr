jQuery ->
  initDropzone()

initDropzone = ->
  if $("#book_dropzone").length > 0
    Dropzone.autoDiscover = false
    book_dropzone = new Dropzone("#book_dropzone", {paramName: "storage"})

    book_dropzone.on "success", (file, date) ->
      file.previewElement.accessKey = date["id"]
      book_dropzone.options.thumbnail(file, date.cover.thumb.url)

    book_dropzone.on "error", (file) ->
      this.removeFile file

    book_dropzone.on "addedfile", (file) ->
      removeButton = Dropzone.createElement("<button>Remove file</button>")
      _this = this
      removeButton.addEventListener "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        _this.removeFile file
        deleteBookToServer(file.previewElement.accessKey)
      file.previewElement.appendChild removeButton

deleteBookToServer = (book_id) ->
  $.ajax(
    url: "/books/#{book_id}",
    type: "DELETE"
  ).done ->
    alert "delete success"

