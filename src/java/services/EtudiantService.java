package services;

import dao.EtudiantDao;
import entities.Etudiant;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class EtudiantService implements IService<Etudiant> {

    private final EtudiantDao etudiantDao;

    public EtudiantService() {
        this.etudiantDao = new EtudiantDao();
    }

    public EtudiantService(EtudiantDao etudiantDao) {
        this.etudiantDao = etudiantDao;
    }
    public Etudiant findEtudiantByEmail(String email) {
        return etudiantDao.findEtudiantByEmail(email);
}
    public Etudiant findEtudiantByCne(String cne) {
        return etudiantDao.findByCne(cne);
    }

    @Override
    public boolean create(Etudiant o) {
        return etudiantDao.create(o);
    }

    @Override
    public boolean delete(Etudiant o) {
        return etudiantDao.delete(o);
    }

    @Override
    public boolean update(Etudiant o) {
        return etudiantDao.update(o);
    }

    @Override
    public List<Etudiant> findAll() {
        return etudiantDao.findAll();
    }

    @Override
    public Etudiant findById(int id) {
        return etudiantDao.findById(id);
    }
}