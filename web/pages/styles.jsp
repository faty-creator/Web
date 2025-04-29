<style>
    /* ========== STUDENT LIST STYLES ========== */
.student-list-container {
    padding: 2rem;
    animation: fadeIn 0.5s ease-out;
}

.student-card {
    border: none;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    background: #ffffff;
    margin-bottom: 2rem;
}

.student-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.student-card-header {
    background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
    color: white;
    padding: 1.5rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: none;
}

.student-card-header h3 {
    margin: 0;
    font-weight: 600;
    font-size: 1.5rem;
}

.add-student-btn {
    background: rgba(255, 255, 255, 0.2);
    border: 2px solid white;
    border-radius: 50px;
    padding: 0.5rem 1.5rem;
    color: white;
    font-weight: 500;
    transition: all 0.3s;
    display: flex;
    align-items: center;
}

.add-student-btn:hover {
    background: white;
    color: #4361ee;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.student-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 0.75rem;
}

.student-table thead th {
    background-color: #f8f9fa;
    border: none;
    color: #6c757d;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.8rem;
    letter-spacing: 0.5px;
    padding: 1rem;
}

.student-table tbody tr {
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    transition: all 0.3s;
}

.student-table tbody tr:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.student-table td {
    padding: 1.25rem 1rem;
    vertical-align: middle;
    border-top: none;
    border-bottom: none;
}

.student-table td:first-child {
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
}

.student-table td:last-child {
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
}

.action-btn {
    border: none;
    border-radius: 50px;
    padding: 0.5rem 1rem;
    font-size: 0.85rem;
    font-weight: 500;
    transition: all 0.3s;
    display: inline-flex;
    align-items: center;
    margin-right: 0.5rem;
}

.action-btn i {
    margin-right: 0.3rem;
}

.edit-btn {
    background-color: #ffc107;
    color: #212529;
}

.edit-btn:hover {
    background-color: #e0a800;
    transform: translateY(-2px);
}

.delete-btn {
    background-color: #f94144;
    color: white;
}

.delete-btn:hover {
    background-color: #d90429;
    transform: translateY(-2px);
}

/* ========== STUDENT FORM STYLES ========== */
.student-form-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem;
    animation: fadeIn 0.5s ease-out;
}

.student-form-card {
    border: none;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    background: #ffffff;
}

.student-form-header {
    background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
    color: white;
    padding: 1.5rem;
    text-align: center;
}

.student-form-header h3 {
    margin: 0;
    font-weight: 600;
    font-size: 1.5rem;
}

.student-form-body {
    padding: 2rem;
}

.form-group {
    margin-bottom: 1.5rem;
    position: relative;
}

.form-label {
    font-weight: 500;
    color: #495057;
    margin-bottom: 0.5rem;
    display: block;
}

.form-control {
    border: 2px solid #e9ecef;
    border-radius: 10px;
    padding: 0.75rem 1rem;
    font-size: 1rem;
    transition: all 0.3s;
    box-shadow: none;
}

.form-control:focus {
    border-color: #4361ee;
    box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
}

.btn-submit {
    background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
    border: none;
    border-radius: 50px;
    padding: 0.75rem 2rem;
    color: white;
    font-weight: 500;
    transition: all 0.3s;
    display: inline-flex;
    align-items: center;
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
}

.btn-cancel {
    background: #6c757d;
    border: none;
    border-radius: 50px;
    padding: 0.75rem 2rem;
    color: white;
    font-weight: 500;
    transition: all 0.3s;
    display: inline-flex;
    align-items: center;
    margin-left: 1rem;
}

.btn-cancel:hover {
    background: #5a6268;
    transform: translateY(-2px);
}

/* Floating label effect */
.floating-label-group {
    position: relative;
    margin-bottom: 1.5rem;
}

.floating-label {
    position: absolute;
    top: 0.75rem;
    left: 1rem;
    font-size: 0.85rem;
    color: #6c757d;
    transition: all 0.3s;
    pointer-events: none;
    background: white;
    padding: 0 0.25rem;
}

.form-control:focus + .floating-label,
.form-control:not(:placeholder-shown) + .floating-label {
    top: -0.5rem;
    left: 0.75rem;
    font-size: 0.75rem;
    color: #4361ee;
}

/* Password strength indicator */
.password-strength {
    height: 5px;
    background: #e9ecef;
    border-radius: 5px;
    margin-top: 0.5rem;
    overflow: hidden;
}

.strength-bar {
    height: 100%;
    width: 0;
    transition: all 0.3s;
}

.strength-weak {
    background: #f94144;
    width: 30%;
}

.strength-medium {
    background: #f8961e;
    width: 60%;
}

.strength-strong {
    background: #43aa8b;
    width: 90%;
}

.strength-very-strong {
    background: #4cc9f0;
    width: 100%;
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .student-list-container, .student-form-container {
        padding: 1rem;
    }
    
    .action-btn {
        margin-bottom: 0.5rem;
    }
}
    </style>