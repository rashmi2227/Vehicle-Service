function removeSelectedOption(selectElement) {
  const selectedOption = selectElement.value;
  const selectTags = document.querySelectorAll(`select[name="${selectElement.name}"]`);

  selectTags.forEach(function(selectTag) {
    const options = selectTag.options;
    for (let i = 0; i < options.length; i++) {
      const optionValue = options[i].value;
      if (optionValue !== '' && optionValue !== selectedOption) {
        options[i].disabled = false;
      }
    }
  });
}

// Event listener for select tag change
document.addEventListener('change', function(event) {
  const selectElement = event.target;
  if (selectElement.tagName === 'SELECT') {
    removeSelectedOption(selectElement);

    // Disable selected option in other select tags
    const selectedOption = selectElement.value;
    const otherSelectTags = document.querySelectorAll(`select:not([name="${selectElement.name}"])`);

    otherSelectTags.forEach(function(selectTag) {
      const options = selectTag.options;
      for (let i = 0; i < options.length; i++) {
        const optionValue = options[i].value;
        if (optionValue !== '' && optionValue === selectedOption) {
          options[i].disabled = true;
        }
      }
    });
  }
});

// Disable initial selected options on page load
const primaryTechnicianSelect = document.querySelector('select[name="servicerequest[primary_technician_id]"]');
const employeeSelect = document.querySelector('select[name="servicehandler[employee_id]"]');

removeSelectedOption(primaryTechnicianSelect);
removeSelectedOption(employeeSelect);

// Disable default options in employee field if selected in primary technician field
const defaultPrimaryTechnician = primaryTechnicianSelect.value;
const employeeOptions = employeeSelect.options;

for (let i = 0; i < employeeOptions.length; i++) {
  const optionValue = employeeOptions[i].value;
  if (optionValue === defaultPrimaryTechnician) {
    employeeOptions[i].disabled = true;
  }
}
