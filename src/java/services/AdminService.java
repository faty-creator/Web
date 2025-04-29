package services;

import dao.AdminDao; // Ensure you create an AdminDao similar to EtudiantDao
import entities.Admin;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class AdminService implements IService<Admin> {

    private final AdminDao adminDao;

    public AdminService() {
        this.adminDao = new AdminDao();
    }

    public AdminService(AdminDao adminDao) {
        this.adminDao = adminDao;
    }

    @Override
    public boolean create(Admin o) {
        return adminDao.create(o);
    }

    @Override
    public boolean delete(Admin o) {
        return adminDao.delete(o);
    }

    @Override
    public boolean update(Admin o) {
        return adminDao.update(o);
    }

    @Override
    public List<Admin> findAll() {
        return adminDao.findAll();
    }

    @Override
    public Admin findById(int id) {
        return adminDao.findById(id);
    }
    
     public Admin findAdminByEmail(String email) {
        return adminDao.findByEmail(email);
    }
     
}