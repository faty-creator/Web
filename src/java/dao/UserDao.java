package dao;

import entities.Etudiant;
import entities.User;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import util.HibernateUtil;

import java.util.List;
import org.hibernate.Transaction;

public class UserDao extends AbstractDao<User> {

    public UserDao() {
        super(User.class);
    }

     public List<User> findByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        List<User> users = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            users = session.getNamedQuery("findByEmail").setParameter("email", email).list();
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
        return users;
    }
}