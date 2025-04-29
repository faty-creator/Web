/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Admin;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class AdminDao extends AbstractDao<Admin> {

    public AdminDao() {
        super(Admin.class);
    }
    
    public Admin findByEmail(String email) {
       Session session = null;
        Transaction tx = null;
        Admin admin = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            admin = (Admin) session.getNamedQuery("findAdminByEmail")
                    .setParameter("email", email)
                    .uniqueResult();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return admin;
    }
}
