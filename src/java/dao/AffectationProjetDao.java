package dao;

import entities.AffectationProjet;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import util.HibernateUtil;

import java.util.List;

public class AffectationProjetDao extends AbstractDao<AffectationProjet> {

    public AffectationProjetDao() {
        super(AffectationProjet.class);
    }

    @Override
    public List<AffectationProjet> findAll() {
        Session session = null;
        List<AffectationProjet> affectations = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            affectations = session.getNamedQuery("AffectationProjet.findAll").list();
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return affectations;
    }

    public AffectationProjet findByEtudiantAndProjet(int etudiantId, int projetId) {
        Session session = null;
        AffectationProjet affectation = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            affectation = (AffectationProjet) session.getNamedQuery("AffectationProjet.findByEtudiantAndProjet")
                    .setParameter("etudiantId", etudiantId)
                    .setParameter("projetId", projetId)
                    .uniqueResult();
        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return affectation;
    }
}