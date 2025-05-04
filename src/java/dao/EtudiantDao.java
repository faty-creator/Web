package dao;

import entities.Etudiant;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import util.HibernateUtil;

import java.util.List;
import org.hibernate.Transaction;

public class EtudiantDao extends AbstractDao<Etudiant> {

    public EtudiantDao() {
        super(Etudiant.class);
    }

    public Etudiant findByCne(String cne) {
        Session session = null;
        Etudiant etudiant = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            etudiant = (Etudiant) session.getNamedQuery("findByCne")
                    .setParameter("cne", cne)
                    .uniqueResult();
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return etudiant;
    }


    public Etudiant findEtudiantByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        Etudiant etudiant = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            etudiant = (Etudiant) session.getNamedQuery("findByEmail")
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
        return etudiant;
    }
    public Etudiant findById(Long id) {
    Session session = null;
    Transaction tx = null;
    Etudiant etudiant = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        etudiant = (Etudiant) session.get(Etudiant.class, id);
        tx.commit();
    } catch (HibernateException e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) {
            session.close();
        }
    }
    return etudiant;
}
   public boolean update(Etudiant etudiant) {
    Session session = null;
    Transaction tx = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        session.update(etudiant);
        tx.commit();
        return true;
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
        return false;
    } finally {
        if (session != null) {
            session.close();
        }
    }
}

}
