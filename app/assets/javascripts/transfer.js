/**
 * Method: load
 *
 * Description: load the transfer screen
 *
 * @author Carl Anderson
 */
load = function(){
    $("#startTransferBtn").off("click").on("click",function(){
        $("#transferModal").modal("show");
    })

    $("select").select2({dropdownCssClass: 'dropdown-inverse'});

    $("#submitTransfer").off("click").on("click",function(){

        var data = {};
        $(".transfer-input").each(function(){
            var name = this.getAttribute("name");
            if(name !== null && name !== "") {
                data[this.getAttribute("name")] = $(this).val();
            }
        });

        $.ajax({
            url:'transfer',
            method:'POST',
            data:data,
            error: function(xhr,status,error){
                $("#errorModal").modal("show");
                $(".error-message").html("Failed to contact server");
            },
            success: function(result,status,xhr){
                transferResponse(result);
            }
        });

    })
};

/**
 * Method: transferResponse
 *
 * Description: Transfer Response
 *
 * @author Carl Anderson
 */
transferResponse = function(json){
    if(json.valid){

        $("#transferModal").modal('hide');

        $("#transferContainer").load('/home/transfers');
        $("#userInfoContainer").load('/home/user_information');

    }else{
        $("#errorModal").modal("show");
        $(".error-message").html(json.message);
    }
}