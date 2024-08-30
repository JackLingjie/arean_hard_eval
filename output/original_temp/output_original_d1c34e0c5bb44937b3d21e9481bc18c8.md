**Modified Code with Minlength and Maxlength Validation**

The code has been updated to include minlength and maxlength attributes for the `title` input field. 

```html
<div class="modal fade" id="editForm" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-modify border-radius-10">
            <div class="modal-header modal-body-padding">
                <h2 class="modal-title mb-0 pb-0 text-black-title"><?=$_lang['ALBUM_PHOTOS_DELETE_TITLE']?></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editFormPhoto" action="javascript:fn.popupActionHandler.submit('editFormPhoto')" method="post" accept-charset="UTF8">
                <div class="modal-body modal-body-padding">
                    <input name="p" type="hidden" value="photo" />
                    <input name="a" type="hidden" value="editPhoto" />
                    <input name="id" type="hidden"  />

                    <div class="formGroup">
                        <label class="text-black-title"><b class="req">*</b> <?= $_lang['GLB_OBJ_TITLE'] ?>:</label>
                        <input 
                            name="title" 
                            minlength="1" 
                            maxlength="100" 
                            type="text" 
                            class="formControl border-radius-6" 
                            placeholder="<?=$_lang['ALBUM_ADD_TITLE_PLACEHOLDER']?>"
                        />
                    </div>

                    <div class="formGroup">
                        <label class="text-black-title"><?= $_lang['GLB_OBJ_DESC'] ?>:</label>
                        <textarea 
                            name="desc" 
                            maxlength="5000" 
                            class="formControl border-radius-6" 
                            placeholder="<?=$_lang['ALBUM_ADD_DESCRIPTION_PLACEHOLDER']?>"
                        ></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-body-padding">
                    <button type="button" class="btn" data-bs-dismiss="modal">Cancel</button>
                    <input id="btnSubmit" type="submit" form="editFormPhoto" class="btn btn-default border-radius-20" value="<?= $_lang['GLB_SAVE_CHANGES'] ?>" />
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    var editPhotoModal = document.getElementById('editForm');
    var deletePhotoModal = document.getElementById('deleteForm');

    editPhotoModal.addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var photoEditId = button.getAttribute('data-photo-id');
        var photoTitle = button.getAttribute('data-title');
        var photoDesc = button.getAttribute('data-desc');

        editPhotoModal.querySelector('#editFormPhoto input[name="id"]').value = photoEditId;
        editPhotoModal.querySelector('#editFormPhoto input[name="title"]').value = photoTitle;
        editPhotoModal.querySelector('#editFormPhoto textarea[name="desc"]').value = photoDesc;
    });

    deletePhotoModal.addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        deletePhotoModal.querySelector('#deleteFormPhoto input[name="id"]').value = button.getAttribute('data-photo-id');
    });
</script>
```

**Explanation**

- The `minlength` attribute ensures that the input field for the title must contain at least 1 character.
- The `maxlength` attribute limits the title input field to a maximum of 100 characters.
- The `maxlength` attribute for the description textarea has been updated to 5000 characters.

**Example Use Cases**

- When editing a photo, ensure the title is at least 1 character long.
- When editing a photo, the title cannot exceed 100 characters.
- When editing a photo, the description can be up to 5000 characters long.