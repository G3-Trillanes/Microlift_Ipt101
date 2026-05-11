import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm'

const supabaseUrl = 'https://iuaxqrahkllnodwmxlri.supabase.co'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1YXhxcmFoa2xsbm9kd214bHJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgyNDk2NjYsImV4cCI6MjA5MzgyNTY2Nn0.37G8mw4nIuc2cARhfc3UnShd4RfRsH503lFhoEdwD9I'

const supabase = createClient(supabaseUrl, supabaseKey)

const searchInputs = {
    admin: document.getElementById('admin-search'),
    employer: document.getElementById('employer-search'),
    jobHunter: document.getElementById('jh-search'),
    job: document.getElementById('job-search'),
    payment: document.getElementById('payment-search')
};

const filters = {
    from: document.getElementById('payment-from'),
    to: document.getElementById('payment-to'),
    admin: document.getElementById('admin-status-filter'),
    jh: document.getElementById('jh-filter'),
    j: document.getElementById('j-status-filter')
}

const printButtons = {
    admin: document.getElementById('print-admins'),
    employer: document.getElementById('print-employers'),
    jobHunter: document.getElementById('print-job-hunters'),
    job: document.getElementById('print-jobs'),
    payment: document.getElementById('print-payments')
};

const exportButtons = {
    admin: document.getElementById('export-admin'),
    employer: document.getElementById('export-emp'),
    jobHunter: document.getElementById('export-jh'),
    job: document.getElementById('export-j'),
    payment: document.getElementById('export-pay')
};
/**
 * Fetches generic table data from Supabase and passes it to the rendering function.
 */
async function retrieveTableDataUponOpen(table, id, query, filter) {
    // Initialize the base Supabase request to select all columns from the specified table
    let request = supabase
        .from(table)
        .select('*')

    console.log(filter)
    if (filter) {
        if (table === 'admins_table') {

            request = request.eq('status', filter)
        }

        else if (table === 'job_hunters') {
            request = request.eq('availability', filter)
        }
    }
    // If a search query is provided, apply it as an OR condition to filter the results
    if (query) {
        request = request.or(query)
    }

    // Execute the database request
    let { data, error } = await request

    // Handle potential database errors
    if (error) {
        console.log(error)
        return
    }

    // Pass the retrieved data and target UI element to the rendering helper
    renderTables(table, data, id)
}

/**
 * Dynamically builds and injects HTML table rows based on the specific table being viewed.
 */
async function renderTables(table, data, id) {
    const tbody = document.querySelector(id)

    // Clear previous rows to prevent duplicate data appending on subsequent searches/loads
    tbody.innerHTML = ''

    // =========================
    // ADMINS TABLE RENDERING
    // =========================
    if (table === 'admins_table') {
        data.forEach(row => {
            // Determine background color based on admin status
            const statusColor =
                row.status === 'Active' ? '#01b301' : // Green
                    row.status === 'Inactive' ? '#c08600' : // Orange/Yellow
                        '#af0604' // Red for Suspended/Other

            const tr = document.createElement('tr')

            // Build the table row injecting data and dynamic styles
            tr.innerHTML = `
                <td style="text-align:center;">${row.admin_id}</td>
                <td style="text-align:center;">${row.admin_name}</td>
                <td style="text-align:center;">${row.admin_email}</td>
                <td style="text-align:center;">${row.admin_location}</td>
                <td style="background-color:${statusColor}; color:#ffffff; font-weight:bold; text-align:center;">
                    ${row.status}
                </td>
            `
            tbody.appendChild(tr)
        })
    }

    // =========================
    // EMPLOYERS TABLE RENDERING
    // =========================
    else if (table === 'employers') {
        data.forEach(row => {
            const tr = document.createElement('tr')

            // Build the basic table row for employers
            tr.innerHTML = `
                <td style="text-align:center;">${row.employer_id}</td>
                <td style="text-align:center;">${row.employer_name}</td>
                <td style="text-align:center;">${row.employer_contact}</td>
                <td style="text-align:center;">${row.employer_location}</td>
                <td style="text-align:center;">${row.industry}</td>
            `
            tbody.appendChild(tr)
        })
    }

    // =========================
    // JOB HUNTERS TABLE RENDERING
    // =========================
    else if (table === 'job_hunters') {
        data.forEach(row => {
            // Determine background color based on availability
            const availabilityColor =
                row.availability === 'Available' ? '#01b301' : '#af0604'

            const tr = document.createElement('tr')

            // Build the table row with the dynamic availability badge
            tr.innerHTML = `
                <td style="text-align:center;">${row.job_hunter_id}</td>
                <td style="text-align:center;">${row.job_hunter_name}</td>
                <td style="text-align:center;">${row.job_hunter_email}</td>
                <td style="text-align:center;">${row.job_hunter_location}</td>
                <td style="background-color:${availabilityColor}; color:#ffffff; font-weight:bold; text-align:center;">
                    ${row.availability}
                </td>
            `
            tbody.appendChild(tr)
        })
    }
}

/**
 * Fetches payment logs (receipts) from the database.
 * @param {string} query - Optional search query to filter specific payments.
 */
async function retrieveReceipts(query, filter) {
    let response = supabase
        .from('payments')
        .select('*')
    console.log(filter)
    if (filter?.[0] && filter?.[1]) {
        response = response
            .gte('payment_date', filter[0])
            .lte('payment_date', filter[1])
    }

    if (query) {
        response = response.or(query)
    }

    let { data, error } = await response

    if (error) {
        console.log(error)
        return
    }

    console.log(data)
    renderReceipts(data)
}

/**
 * Dynamically builds and injects payment receipt cards into the UI.
 */
function renderReceipts(data) {
    const receipt = document.getElementById('receipt-container')

    // Clear old content to prevent stacking during searches
    receipt.innerHTML = ''

    data.forEach(row => {
        // 1. Parse the ISO date string from the database
        const rawDate = new Date(row.payment_date);

        // 2. Format it to a human-readable local format (e.g., "April 12, 2026, 10:00 AM")
        const formattedDate = rawDate.toLocaleString('en-US', {
            month: 'long',
            day: 'numeric',
            year: 'numeric',
            hour: 'numeric',
            minute: '2-digit',
            hour12: true
        });

        // 3. Create the container card for the receipt
        const card = document.createElement('div')
        card.className = 'receipt-card'

        // 4. Inject the HTML and formatted data into the card
        card.innerHTML = `
            <h2 style="text-align:center">${row.payment_id}</h2>
            <hr>
            <p><b>Job:</b> ${row.job_id}</p>
            <p><b>Worker:</b> ${row.job_hunter_id}</p>
            <p><b>Transaction Date:</b> ${formattedDate}</p>
            <p><b>Payment Reference:</b> ${row.payment_reference}</p>
            <br>
            <p style="text-align:right; font-size:20px;">
                <b>P ${row.payment_amount}</b>
            </p>
        `

        receipt.appendChild(card)
    })
}

/**
 * Fetches jobs and joins the employer data to display company names.
 */
async function retrieveJobsList(query, filter) {
    let response = supabase
        .from('jobs_with_employers')
        // Perform a foreign key join to fetch the associated employer's name and ID
        .select(`
            *
        `)

    if (filter) {
        if (filter === 'Open') {
            response = response.or('job_status.eq.Open,job_status.eq.Reopened')
        } else {
            response = response.eq('job_status', filter)
        }
    }

    // Apply search query filters
    if (query) {
        response = response.or(query)
    }

    let { data, error } = await response

    if (error) {
        console.log(error)
        return null
    }

    // Log data for debugging purposes
    console.log(data)


    // Pass the joined data to the job card rendering function
    renderJobs(data)
    return data
}

/**
 * Dynamically builds and injects job posting cards into the UI.
 * The array of job objects (with joined employer data).
 */
function renderJobs(data) {
    const job = document.getElementById('job-container')

    // Clear old content to prevent stacking during searches
    job.innerHTML = ''

    data.forEach(row => {
        // Create the card container
        const card = document.createElement('div')
        card.className = 'job-card'
        // Store the description in a dataset attribute for potential modal or toggle usage
        card.dataset.description = row.job_description || ''

        // Build the main card body, accessing nested employer data
        card.innerHTML = `
            <h2 style="font-size:20px;">${row.job_name}</h2>
            <hr>
            <p>${row.employer_name}</p>
            <p>${row.job_type}</p>
            <p>${row.job_location}</p>
            <br>
        `

        // Append conditional UI badges based on the job's current status
        if (row.job_status === 'Open' || row.job_status === 'Reopened') {
            card.innerHTML += `
                <p style="border-radius:10px; background-color:#01b301; text-align:right; color:white; padding:6px 12px; width:fit-content;">
                    <b>Open</b>
                </p>
            `
        } else if (row.job_status === 'Filled') {
            card.innerHTML += `
                <p style="border-radius:10px; background-color:#c08600; text-align:right; color:white; padding:6px 12px; width:fit-content;">
                    <b>Filled</b>
                </p>
            `
        } else {
            // Closed status
            card.innerHTML += `
                <p style="border-radius:10px; background-color:#af0604; text-align:right; color:white; padding:6px 12px; width:fit-content;">
                    <b>Closed</b>
                </p>
            `
        }

        job.appendChild(card)
    })
}

async function exportTableToPdf(table) {
    //Fetch data from Supabase
    const { data, error } = await supabase
        .from(table)
        .select('*');

    if (error) return console.error(error);

    //Create a hidden window for printing
    const printWindow = window.open('', '_blank');

    // Build a simple HTML table string
    let tableHtml = `<table border="1" style="width:100%; border-collapse: collapse;">
    <thead>
      <tr>${Object.keys(data[0]).map(key => `<th>${key}</th>`).join('')}</tr>
    </thead>
    <tbody>
      ${data.map(row => `
        <tr>${Object.values(row).map(val => `<td>${val}</td>`).join('')}</tr>
      `).join('')}
    </tbody>
  </table>`;

    //Inject into the new window and trigger print
    printWindow.document.write(`<html><body>${tableHtml}</body></html>`);
    printWindow.document.close();
    printWindow.print();
}

async function exportToCSV(table) {
    const { data, error } = await supabase
        .from(table)
        .select('*')

    if (error) {
        console.error(error)
        return
    }

    if (!data || data.length === 0) {
        alert('No data found')
        return
    }

    // Convert JSON to CSV
    const headers = Object.keys(data[0]).join(',')

    const rows = data.map(row =>
        Object.values(row)
            .map(value =>
                `"${String(value ?? '').replace(/"/g, '""')}"`
            )
            .join(',')
    )

    const csv = [headers, ...rows].join('\n')

    // CREATE FILE
    const blob = new Blob([csv], {
        type: 'text/csv;charset=utf-8;'
    })

    // CREATE DOWNLOAD LINK
    const url = URL.createObjectURL(blob)

    const link = document.createElement('a')
    link.href = url
    link.download = `${table}.csv`

    // DOWNLOAD FILE
    document.body.appendChild(link)
    link.click()

    // CLEANUP
    document.body.removeChild(link)
    URL.revokeObjectURL(url)
}


// ADMIN SEARCH INPUT (live search on typing)
searchInputs.admin.addEventListener('input', async () => {
    // current filter dropdown value (e.g. status/type)
    const value = filters.admin.value;

    // search input value
    let query = searchInputs.admin.value

    // fetch filtered admin table data
    await retrieveTableDataUponOpen(
        'admins_table',
        '#admins tbody',
        // search across multiple columns using ilike
        `admin_id.ilike.${query}%,admin_name.ilike.${query}%,admin_email.ilike.${query}%,admin_location.ilike.${query}%`,
        value
    );
});


// ADMIN FILTER CHANGE (dropdown filter update)
filters.admin.addEventListener('change', async () => {
    const value = filters.admin.value;

    let query = searchInputs.admin.value

    // re-fetch data when filter changes
    await retrieveTableDataUponOpen(
        'admins_table',
        '#admins tbody',
        `admin_id.ilike.${query}%,admin_name.ilike.${query}%,admin_email.ilike.${query}%,admin_location.ilike.${query}%`,
        value
    );
});


// EMPLOYER SEARCH INPUT
searchInputs.employer.addEventListener('input', async () => {
    let query = searchInputs.employer.value;

    // fetch employer data with search filters
    await retrieveTableDataUponOpen(
        'employers',
        '#employers tbody',
        `employer_id.ilike.${query}%,employer_name.ilike.${query}%,industry.ilike.${query}%,employer_location.ilike.${query}%`
    );
});


// JOB HUNTER SEARCH INPUT
searchInputs.jobHunter.addEventListener('input', async () => {
    // filter value (dropdown like status/category)
    const value = filters.jh.value;

    let query = searchInputs.jobHunter.value

    // fetch job hunters with search filters
    await retrieveTableDataUponOpen(
        'job_hunters',
        '#job-hunters tbody',
        `job_hunter_id.ilike.${query}%,job_hunter_name.ilike.${query}%,job_hunter_email.ilike.${query}%,job_hunter_location.ilike.${query}%`,
        value
    );
});


// JOB HUNTER FILTER CHANGE (dropdown update)
filters.jh.addEventListener('change', async () => {
    const value = filters.jh.value;

    let query = searchInputs.jobHunter.value

    // re-fetch filtered job hunters
    await retrieveTableDataUponOpen(
        'job_hunters',
        '#job-hunters tbody',
        `job_hunter_id.ilike.${query}%,job_hunter_name.ilike.${query}%,job_hunter_email.ilike.${query}%,job_hunter_location.ilike.${query}%`,
        value
    );
});


// JOB SEARCH INPUT (jobs table live search)
searchInputs.job.addEventListener('input', async () => {
    let query = searchInputs.job.value;

    // job filter dropdown value
    const val = filters.j.value

    // fetch jobs with search conditions
    let data = await retrieveJobsList(
        `job_id.ilike.%${query}%,job_location.ilike.%${query}%,employer_name.ilike.%${query}%`,
        val
    );

    // if search is empty, reload filtered default data
    if (query === '') {
        await retrieveJobsList(val);
    }
});


// JOB FILTER CHANGE (dropdown filter update)
filters.j.addEventListener('input', async () => {
    let query = searchInputs.job.value;

    const val = filters.j.value

    // re-run job search with updated filter
    let data = await retrieveJobsList(
        `job_id.ilike.%${query}%,job_location.ilike.%${query}%,employer_name.ilike.%${query}%`,
        val
    );
});

searchInputs.payment.addEventListener('input', async () => {
    // Get text typed in payment search bar
    let query = searchInputs.payment.value;

    // Store selected date range
    const dateRange = [];

    // Convert "from" date to ISO format
    const from = filters.from.value
        ? new Date(filters.from.value).toISOString()
        : null;

    // Convert "to" date to ISO format
    const to = filters.to.value
        ? new Date(filters.to.value).toISOString()
        : null;

    // Save dates into array
    dateRange[0] = from;
    dateRange[1] = to;

    // Search receipts using text + date filters
    await retrieveReceipts(
        `payment_id.ilike.${query}%,job_hunter_id.ilike.${query}%,job_id.ilike.${query}%,payment_reference.ilike.${query}%`,
        dateRange
    );
});

// Run filter when "from" date changes
filters.from.addEventListener('change', async () => {

    let query = searchInputs.payment.value;
    const dateRange = [];

    // Convert selected dates
    const from = filters.from.value
        ? new Date(filters.from.value).toISOString()
        : null;

    const to = filters.to.value
        ? new Date(filters.to.value).toISOString()
        : null;

    // Save date range
    dateRange[0] = from;
    dateRange[1] = to;

    // Debug logs
    console.log("FROM:", from);
    console.log("TO:", to);
    console.log("DATE RANGE:", dateRange);

    // Search filter string
    let filterString =
        `payment_id.ilike.*${query}*,job_hunter_id.ilike.*${query}*,job_id.ilike.*${query}*,payment_reference.ilike.*${query}*`;

    // Retrieve filtered receipts
    await retrieveReceipts(filterString, dateRange);
});


// Run filter when "to" date changes
filters.to.addEventListener('change', async () => {

    let query = searchInputs.payment.value;
    const dateRange = [];

    // Convert selected dates
    const from = filters.from.value
        ? new Date(filters.from.value).toISOString()
        : null;

    const to = filters.to.value
        ? new Date(filters.to.value).toISOString()
        : null;

    // Save date range
    dateRange[0] = from;
    dateRange[1] = to;

    // Debug logs
    console.log("FROM:", from);
    console.log("TO:", to);
    console.log("DATE RANGE:", dateRange);

    let filterString =
        `payment_id.ilike.*${query}*,job_hunter_id.ilike.*${query}*,job_id.ilike.*${query}*,payment_reference.ilike.*${query}*`;

    // Retrieve filtered receipts
    await retrieveReceipts(filterString, dateRange);
});



// Print buttons for each table
printButtons.admin.addEventListener('click', async () => {
    await exportTableToPdf('admins_table');
});

printButtons.employer.addEventListener('click', async () => {
    await exportTableToPdf('employers');
});

printButtons.jobHunter.addEventListener('click', async () => {
    await exportTableToPdf('job_hunters');
});

printButtons.job.addEventListener('click', async () => {
    await exportTableToPdf('jobs');
});

printButtons.payment.addEventListener('click', async () => {
    await exportTableToPdf('payments');
});


// Export CSV buttons for each table
exportButtons.admin.addEventListener('click', async () => {
    await exportToCSV('admins_table');
});

exportButtons.employer.addEventListener('click', async () => {
    await exportToCSV('employers');
});

exportButtons.jobHunter.addEventListener('click', async () => {
    await exportToCSV('job_hunters');
});

exportButtons.job.addEventListener('click', async () => {
    await exportToCSV('jobs');
});

exportButtons.payment.addEventListener('click', async () => {
    await exportToCSV('payments');
});


await retrieveTableDataUponOpen('admins_table', '#admins tbody')

await retrieveTableDataUponOpen('employers', '#employers tbody')

await retrieveTableDataUponOpen('job_hunters', '#job-hunters tbody')

retrieveReceipts()

retrieveJobsList()


