package dao;

import entities.ProjetEtudiant;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import util.HibernateUtil;

import java.util.List;
import org.hibernate.Transaction;

public class ProjetEtudiantDao extends AbstractDao<ProjetEtudiant> {

    public ProjetEtudiantDao() {
        super(ProjetEtudiant.class);
    }

    @Override
    public List<ProjetEtudiant> findAll() {
        Session session = null;
        List<ProjetEtudiant> projets = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            projets = session.getNamedQuery("ProjetEtudiant.findAll").list();
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return projets;
    }

   public List<ProjetEtudiant> findByTitre(String titre) {
    Session session = null;
    List<ProjetEtudiant> projets = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        projets = session.getNamedQuery("ProjetEtudiant.findByTitre")
                .setParameter("titre", titre)
                .list();
    } catch (HibernateException e) {
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }
    return projets;
}

public List<ProjetEtudiant> findByEncadrent(String encadrent) {
    Session session = null;
    List<ProjetEtudiant> projets = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        projets = session.getNamedQuery("ProjetEtudiant.findByEncadrent")
                .setParameter("encadrent", encadrent)
                .list();
    } catch (HibernateException e) {
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }
    return projets;
}


 public List<Object[]> countEtudiantsByProjet() {
        Session session = null;
        Transaction tx = null;
        List<Object[]> stats = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

             stats = session.getNamedQuery("ProjetEtudiant.countEtudiantsByProjet").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return stats;
    }

    // Nouvelle méthode pour compter toutes les entrées de ProjetEtudiant
    public long countAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        long count = 0;
        try {
            tx = session.beginTransaction();
            count = ((Number) session.createSQLQuery("SELECT COUNT(*) FROM projet_etudiant").uniqueResult()).longValue();
            System.out.println("Nombre total de Projet : " + count); // Log pour déboguer
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count;
    }
}