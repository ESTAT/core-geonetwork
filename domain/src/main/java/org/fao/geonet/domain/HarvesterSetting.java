package org.fao.geonet.domain;

import com.google.common.collect.Sets;
import org.fao.geonet.entitylistener.HarvesterSettingEntityListenerManager;
import org.hibernate.annotations.Type;

import java.util.HashSet;
import java.util.Set;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.persistence.*;

import static javax.persistence.CascadeType.*;

/**
 * An entity representing a harvester configuration setting.
 * <p/>
 * Harvester settings are represented by a tree. One should use the {@link org.fao.geonet.repository.HarvesterSettingRepository} to
 * traverse
 * the hierarchy.
 *
 * @author Jesse
 */
@Entity
@Table(name = "HarvesterSettings")
@Access(AccessType.PROPERTY)
@EntityListeners(HarvesterSettingEntityListenerManager.class)
@SequenceGenerator(name=HarvesterSetting.ID_SEQ_NAME, initialValue=100, allocationSize=1)
public class HarvesterSetting extends GeonetEntity {
    static final String ID_SEQ_NAME = "harvester_setting_id_seq";
    private static final HashSet<String> EXCLUDE_FROM_XML = Sets.newHashSet("valueAsBool", "valueAsInt");

    private int _id;
    private HarvesterSetting _parent;
    private String _name;
    private String _value;
    private char encrypted  = Constants.YN_FALSE;

    /**
     * Get the setting id. This is a generated value and as such new instances should not have this set as it will simply be ignored and
     * could result in reduced performance.
     *
     * @return the setting id
     */
    @Id
    @GeneratedValue (strategy = GenerationType.SEQUENCE, generator = ID_SEQ_NAME)
    @Column(name = "id", nullable = false)
    public int getId() {
        return _id;
    }

    /**
     * Set the setting id. This is a generated value and as such new instances should not have this set as it will simply be ignored and
     * could result in reduced performance.
     *
     * @param id the setting id
     * @return this setting object
     */
    public HarvesterSetting setId(int id) {
        this._id = id;
        return this;
    }

    /**
     * Get the parent setting object. This is a nullable property.
     */
    @OneToOne(optional = true, fetch = FetchType.LAZY, cascade = {PERSIST, MERGE, DETACH})
    @JoinColumn(name = "parentid")
    public
    @Nullable
    HarvesterSetting getParent() {
        return _parent;
    }

    /**
     * Set the parent setting object for this setting. The may be null.
     *
     * @param parent the parent setting object
     * @return this setting object
     */
    public
    @Nonnull
    HarvesterSetting setParent(@Nullable HarvesterSetting parent) {
        this._parent = parent;
        return this;
    }

    /**
     * Get the setting name. This is a required property.
     *
     * @return the setting name.
     */
    @Column(name = "name", nullable = false)
    public
    @Nonnull
    String getName() {
        return _name;
    }

    /**
     * Set the setting name. This is a required property.
     *
     * @param name the setting name. This is a required property.
     * @return this setting object
     */
    public
    @Nonnull
    HarvesterSetting setName(@Nonnull String name) {
        this._name = name;
        return this;
    }

    /**
     * Get the setting value. This is a nullable property.
     *
     * @return
     */
    @Lob
    @Column(name = "value", nullable = true)
    @Type(type="org.hibernate.type.StringClobType") // this is a work around for postgres so postgres can correctly load clobs
    public
    @Nullable
    String getValue() {
        return _value;
    }

    public HarvesterSetting setValue(@Nullable String value) {
        this._value = value;
        return this;
    }

    /**
     * Get the value as an integer. This may throw {@link NullPointerException} if the value is null or {@link NumberFormatException}
     * if the
     * value is not a valid number.
     *
     * @return the value as an integer
     */
    @Transient
    public int getValueAsInt() throws NullPointerException, NumberFormatException {
        if (getValue() == null) {
            throw new NullPointerException("Setting value of " + getName() + " is null");
        }
        return Integer.parseInt(getValue());
    }

    /**
     * Set the value of setting with an integer.
     *
     * @param value the new value
     * @return this setting object
     */
    public HarvesterSetting setValue(int value) {
        return setValue(String.valueOf(value));
    }

    /**
     * Get the values as a boolean. Returns false if the values is not a boolean.
     *
     * @return the values as a boolean
     * @throws NullPointerException if the value is null.
     */
    @Transient
    public boolean getValueAsBool() throws NullPointerException {
        if (getValue() == null) {
            throw new NullPointerException("Setting value of " + getName() + " is null");
        }
        return Boolean.parseBoolean(_value);
    }

    /**
     * Set the value of setting with a boolean.
     *
     * @param value the new value
     * @return this setting object
     */
    public HarvesterSetting setValue(boolean value) {
        return setValue(String.valueOf(value));
    }

    /**
     * For backwards compatibility we need the activated column to be either 'n' or 'y'.
     * This is a workaround to allow this until future
     * versions of JPA that allow different ways of controlling how types are mapped to the database.
     */
    @Column(name = "encrypted", nullable = false, length = 1, columnDefinition="char default 'n'")
    protected char getEncrypted_JpaWorkaround() {
        return encrypted;
    }

    /**
     * Set the column value. Constants.YN_ENABLED for true Constants.YN_DISABLED for false.
     *
     * @param encryptedValue the column value. Constants.YN_ENABLED for true Constants.YN_DISABLED for false.
     * @return
     */
    protected void setEncrypted_JpaWorkaround(char encryptedValue) {
        encrypted = encryptedValue;
    }

    /**
     * Return true if the setting is public.
     *
     * @return true if the setting is public.
     */
    @Transient
    public boolean isEncrypted() {
        return Constants.toBoolean_fromYNChar(getEncrypted_JpaWorkaround());
    }

    /**
     * Set true if the setting is private.
     *
     * @param encrypted true if the setting is private.
     */
    public HarvesterSetting setEncrypted(boolean encrypted) {
        setEncrypted_JpaWorkaround(Constants.toYN_EnabledChar(encrypted));
        return this;
    }

    @Override
    protected Set<String> propertiesToExcludeFromXml() {
        return EXCLUDE_FROM_XML;
    }

    @Override
    public String toString() {
        return "Setting [id=" + _id + ", name=" + _name + ", value=" + _value + "]";
    }
}
