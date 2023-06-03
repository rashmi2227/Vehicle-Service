function removeSelectedOption(selectElement) {
  const selectedOption = selectElement.value;
  const selectTags = document.querySelectorAll(`select[name="${selectElement.name}"]`);

  selectTags.forEach(function(selectTag) {
    const options = selectTag.options;
    for (let i = 0; i < options.length; i++) {
      if (options[i].value === selectedOption) {
        options[i].disabled = true;
      }
    }
  });
}

// Event listener for select tag change
document.addEventListener('change', function(event) {
  const selectElement = event.target;
  if (selectElement.tagName === 'SELECT') {
    removeSelectedOption(selectElement);

    // Enable selected option in primary technician in secondary technicians
    const primaryTechnicianSelect = document.querySelector('select[name="servicerequest[primary_technician_id]"]');
    const secondaryTechnicianSelects = document.querySelectorAll('select[name="servicehandler[subhandler][]"]');

    if (selectElement === primaryTechnicianSelect) {
      const selectedOption = primaryTechnicianSelect.value;

      secondaryTechnicianSelects.forEach(function(selectTag) {
        const options = selectTag.options;
        for (let i = 0; i < options.length; i++) {
          if (options[i].value === selectedOption) {
            options[i].disabled = true;
          }
        }
      });
    }
  }
});

// This code works for disabling the options which is being selected by both the primary and the secondary technician. Now enamble only those options which are still not being selected . For suppose the primary technician first selects the employee#2 and in the secondary technician the fields that are selected is only employee2. Now the primary technician select the employee3 which means that employee1 whihch was earlier being selected for the primary technician is being replace by newly added employee3 this should now enable employee1 to be available to be selected.As primary technician conisists of only one fixed field and no dynamic fields only the secondary technician consists of dyanmic fields
