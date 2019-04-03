$(() => {
    $(document).on('click', '.cwf-buttons a', (e) => {
        const id = $(e.target).data('id');
        const issue_id = $(e.target).data('issue-id');

        $.ajax({
            type: "POST",
            url: `/button/trigger/${id}?issue_id=${issue_id}`,
            dataType: 'json',
            success: (response) => {
                console.log('success: ' + response);
            }
        });

        e.preventDefault();
    });
});