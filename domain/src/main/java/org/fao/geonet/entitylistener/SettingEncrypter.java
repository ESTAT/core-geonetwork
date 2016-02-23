package org.fao.geonet.entitylistener;

import org.apache.commons.lang.StringUtils;
import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.domain.Setting;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

/**
 * Created by jose on 23/02/16.
 */
public class SettingEncrypter implements GeonetworkEntityListener<Setting> {
    @Autowired
    private ApplicationContext context;

    @Override
    public Class<Setting> getEntityClass() {
        return Setting.class;
    }

    @Override
    public void handleEvent(final PersistentEventType type, final Setting entity) {
        // Decrypt password after loading.
        /*if (type == PersistentEventType.PostLoad || type == PersistentEventType.PostUpdate) {
            if (!entity.isEncrypted() || StringUtils.isEmpty(entity.getValue())) {
                entity.setCleanValue(entity.getValue());
            } else {
                StandardPBEStringEncryptor encryptor = (StandardPBEStringEncryptor) ApplicationContextHolder.get().getBean("strongEncryptor");
                entity.setCleanValue(encryptor.decrypt(entity.getValue()));
            }
        }*/

        // Encrypt password before persisting.
        /*if (type == PersistentEventType.PrePersist || type == PersistentEventType.PreUpdate) {
            if (entity.isEncrypted()) {
                StandardPBEStringEncryptor encryptor = (StandardPBEStringEncryptor) ApplicationContextHolder.get().getBean("strongEncryptor");
                entity.setValue(encryptor.encrypt(entity.getValue()));
            }

        }*/
    }

}
