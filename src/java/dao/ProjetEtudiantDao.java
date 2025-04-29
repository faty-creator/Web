package dao;

import entities.ProjetEtudiant;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import util.HibernateUtil;

import java.util.List;

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
}