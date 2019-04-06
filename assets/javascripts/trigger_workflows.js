$(() => {
    $(document).on('click', '.trigger-workflows-buttons a', (e) => {
        const id = $(e.target).data('id');
        const issue_id = $(e.target).data('issue-id');

        console.log(`Trigger start: id=${id} issue_id=${issue_id}`);

        $.ajax({
            type: "POST",
            url: `/button/trigger/${id}?issue_id=${issue_id}`,
            dataType: 'json',
            success: (response) => {
                console.log('Trigger:', response);

                if (response.after_click) {
                    eval(response.after_click);
                }
            }
        });

        e.preventDefault();
    });
});